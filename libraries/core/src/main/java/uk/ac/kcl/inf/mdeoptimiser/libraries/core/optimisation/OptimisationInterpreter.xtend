package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation

import java.util.ArrayList
import java.util.LinkedList
import java.util.List
import java.util.Map
import org.eclipse.core.runtime.IPath
import org.eclipse.core.runtime.Path
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl
import org.eclipse.emf.henshin.model.Module
import org.eclipse.emf.henshin.model.Unit
import org.eclipse.emf.henshin.model.resource.HenshinResourceSet
import org.moeaframework.Instrumenter
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.Optimisation
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenSpec
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.impl.SearchSpecImpl
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.executor.SolutionGenerator
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.executor.UserModelProvider
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.executor.VectorModelProvider
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.moea.MoeaOptimisation
import uk.ac.kcl.inf.mdeoptimiser.libraries.rulegen.RulesGenerator
import uk.ac.kcl.inf.mdeoptimiser.libraries.rulegen.metamodel.Multiplicity
import uk.ac.kcl.inf.mdeoptimiser.libraries.rulegen.metamodel.RuleSpec
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorConverter

class OptimisationInterpreter {

	Optimisation model

	HenshinResourceSet henshinResourceSet
	
	EPackage theMetamodel

	List<Unit> breedingOperators
	
	List<Unit> mutationOperators
	
	IPath projectRootPath;
	
	String vectorFlag = "vector"
	
	VectorConverter vectorConverter

	Map<EPackage, List<Module>> generatedOperators;

	new (String projectPath, Optimisation model){
		this.model = model;
		this.projectRootPath = new Path(projectPath);
		val newResourcePath = projectRootPath + "/" + model.problem.basepath.location
		println("GET RESOURCE SET: " + getResourceSet(newResourcePath))
		val ss = model.search as SearchSpecImpl;
		val rgs = ss.eGet(2, true, false) as EList<RulegenSpec>;
		println("MODEL SEARCH RULEGEN: " + rgs.get(0));
		println("MODEL NODE SPEC: " + rgs.get(0).getNodeSpec());
		println("MODEL EDGE SPEC: " + rgs.get(0).getEdgeSpec());
		vectorConverter = new VectorConverter(this.getMetamodel, rgs.get(0))
	}

	def Instrumenter start() {

		//This model provider loads the model given by the user in the DSL
		if (this.vectorFlag != "vector") {
		var solutionGenerator = new SolutionGenerator(model,
											getBreedingOperators,
											getMutationOperators,
											getModelProvider,
											getMetamodel);
		val metamodel = getMetamodel
		println("Metamodel: " + metamodel);
		println("Metamodel EClassifiers: " + metamodel.getEClassifiers);
		return new MoeaOptimisation().execute(model.solver, solutionGenerator)
		} else {
			println("Vector implementation goes here");
			var solutionGenerator = new SolutionGenerator(model, getModelProvider, getMetamodel);
			return new MoeaOptimisation().execute(model.solver, solutionGenerator)
		}
		
	}

	def IModelProvider getModelProvider(){
		println("MODEL INITIALISER: " + model.problem.modelInitialiser)
		Resource.Factory.Registry.INSTANCE.getExtensionToFactoryMap().put(
    	"nrp", new XMIResourceFactoryImpl());
		if (vectorFlag != "vector") {
			if(model.problem.modelInitialiser !== null){
				return new UserModelProvider(getModelInitialiser(), getResourceSet(projectRootPath.append(model.problem.basepath.location).toPortableString), model.problem.model.location)
			}
	
			return new UserModelProvider(getResourceSet(projectRootPath.append(model.problem.basepath.location).toPortableString), model.problem.model.location)
		
		} else {
			
			return new VectorModelProvider(getResourceSet(projectRootPath.append(model.problem.basepath.location).toPortableString), model.problem.model.location, vectorConverter)
			
		}
	}

	def IModelInitialiser getModelInitialiser(){
		if(model.problem.modelInitialiser !== null){
			return Class.forName(model.problem.modelInitialiser.initialiser).newInstance() as IModelInitialiser
		}

	}

	def getResourceSet(String basePath) {
        if (henshinResourceSet === null) {

            henshinResourceSet = new HenshinResourceSet(basePath);
        }

        henshinResourceSet
    }

    def getMetamodel() {
        if (theMetamodel === null) {
        	if (!model.problem.metamodel.location.endsWith(".ecore")) {
        		// The location is not an ecore file, assume it's a class name
        		val packageInterface = (Class.forName(model.problem.metamodel.location) as Class<EPackage>)
        		theMetamodel = packageInterface.getDeclaredField("eINSTANCE").get(null) as EPackage
        	} else {
 				theMetamodel = getResourceSet(projectRootPath.append(model.problem.basepath.location).toPortableString).registerDynamicEPackages(model.problem.metamodel.location).head
        	}
        }

        theMetamodel
    }

    def getBreedingOperators() {
    	if(breedingOperators === null){

			breedingOperators = new LinkedList
			
			breedingOperators.addAll(model.search.evolvers.filter[ operator | operator.evolverType.getName.equals("BREED")]
				.map[ operator | getResourceSet(projectRootPath.append(model.problem.basepath.location).toPortableString).getModule(URI.createURI(operator.rule_location), false).getUnit(operator.unit)]
			)

    	}

    	breedingOperators
    }

    def getMutationOperators() {

    	//TODO: Doesn't make sense?

    	if(mutationOperators === null){

			mutationOperators = new LinkedList
						
			mutationOperators.addAll(model.search.evolvers.filter[ operator | operator.evolverType.getName.equals("MUTATE")]
				.map[ operator | getResourceSet(projectRootPath.append(model.problem.basepath.location).toPortableString).getModule(URI.createURI(operator.rule_location), false).getUnit(operator.unit)]
			)

    	}

    	//Automatically generate mutations operators
    	var generatedMutations = getRulegenOperators();

    	if(!generatedMutations.empty){

    		//For each of the automatically generated modules, add the generated mutations to the list of evolvers
    		//Are we ever going to have more than one metamodel? Perhaps this should be a pair instead

    		var metamodel = generatedMutations.keySet.head;
    		var mutations = generatedMutations.get(metamodel);

    		mutations.forEach[mutation |
    			mutationOperators.addAll(mutation.allRules)
    		]
    	}

    	mutationOperators
    }

    def List<Multiplicity> getMultiplicityRefinements(){
    	 //A list of multiplicity refinements specified by the user in the DSL.
    	//This is optional.
    	var refinements = model.goal.refinements;

 		val multiplicityRefinements = new ArrayList<Multiplicity>();

 		if(!refinements.empty){
 			refinements.forEach[refinement |
 				multiplicityRefinements.add(new Multiplicity(refinement.node, refinement.edge, refinement.lowerBound, refinement.upperBound, getMetamodel));
 			]
 		}
		println("Multiplicity Refinements" + multiplicityRefinements)
 		return multiplicityRefinements;
    }

    def List<RuleSpec> getRulegenSpecs(){

    	var rulegenSpecs = model.search.rulegen;

    	val ruleSpecs = new ArrayList<RuleSpec>();

 		if(!rulegenSpecs.empty) {

 			rulegenSpecs.forEach[rulegenSpec |

 				//Crete the spec for a node or an edge generation
 				if(rulegenSpec.nodeSpec !== null){
 					ruleSpecs.add(new RuleSpec(rulegenSpec.nodeSpec.node, rulegenSpec.nodeSpec.generationRestriction))
 				} else {
 					ruleSpecs.add(new RuleSpec(rulegenSpec.edgeSpec.node, rulegenSpec.edgeSpec.edge, rulegenSpec.edgeSpec.generationRestriction))
 				}
 			]
 		}
		println("RULESPECS: " + ruleSpecs);
		for (RuleSpec rs : ruleSpecs) {
			println("RuleSpec Node: " + rs.getNode())
			println("RuleSpec Edge: " + rs.getEdge())
			println("RuleSpec Actions: " + rs.getActions())
		}
    	return ruleSpecs;
    }

    /**
     * If there are any rule generation instructions present, then generate the corresponding rules.
     * @return list of generated mutation operators
     */
    def Map<EPackage, List<Module>> getRulegenOperators(){

 		if(this.generatedOperators === null){
 			var multiplicityRefinements = getMultiplicityRefinements();
	    	var rulegenSpecs = getRulegenSpecs();

	  		//Generate the list of modules that are automatically generated
	    	var mutations = new RulesGenerator(getMetamodel, multiplicityRefinements, rulegenSpecs);

	    	this.generatedOperators = mutations.generateRules;
	    	println("GENERATED OPERATORS MATCHING PACKAGES TO HENSHIN MODULES:" + this.generatedOperators);
 		}

 		return this.generatedOperators
    }
}
