/**
 * generated by Xtext 2.14.0
 */
package uk.ac.kcl.mdeoptimise.impl;

import org.eclipse.emf.ecore.EClass;
import org.eclipse.emf.ecore.EDataType;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.emf.ecore.EPackage;

import org.eclipse.emf.ecore.impl.EFactoryImpl;

import org.eclipse.emf.ecore.plugin.EcorePlugin;

import uk.ac.kcl.mdeoptimise.*;

/**
 * <!-- begin-user-doc -->
 * An implementation of the model <b>Factory</b>.
 * <!-- end-user-doc -->
 * @generated
 */
public class MdeoptimiseFactoryImpl extends EFactoryImpl implements MdeoptimiseFactory
{
  /**
   * Creates the default factory implementation.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public static MdeoptimiseFactory init()
  {
    try
    {
      MdeoptimiseFactory theMdeoptimiseFactory = (MdeoptimiseFactory)EPackage.Registry.INSTANCE.getEFactory(MdeoptimisePackage.eNS_URI);
      if (theMdeoptimiseFactory != null)
      {
        return theMdeoptimiseFactory;
      }
    }
    catch (Exception exception)
    {
      EcorePlugin.INSTANCE.log(exception);
    }
    return new MdeoptimiseFactoryImpl();
  }

  /**
   * Creates an instance of the factory.
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MdeoptimiseFactoryImpl()
  {
    super();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public EObject create(EClass eClass)
  {
    switch (eClass.getClassifierID())
    {
      case MdeoptimisePackage.OPTIMISATION: return createOptimisation();
      case MdeoptimisePackage.BASE_PATH_SPEC: return createBasePathSpec();
      case MdeoptimisePackage.META_MODEL_SPEC: return createMetaModelSpec();
      case MdeoptimisePackage.MODEL_PATH_SPEC: return createModelPathSpec();
      case MdeoptimisePackage.OBJECTIVE_INTERPRETER_SPEC: return createObjectiveInterpreterSpec();
      case MdeoptimisePackage.CONSTRAINT_INTERPRETER_SPEC: return createConstraintInterpreterSpec();
      case MdeoptimisePackage.MODEL_INITIALISER_SPEC: return createModelInitialiserSpec();
      case MdeoptimisePackage.RULEGEN_SPEC: return createRulegenSpec();
      case MdeoptimisePackage.RULEGEN_NODE: return createRulegenNode();
      case MdeoptimisePackage.RULEGEN_EDGE: return createRulegenEdge();
      case MdeoptimisePackage.REPORT_INTERPRETER_SPEC: return createReportInterpreterSpec();
      case MdeoptimisePackage.EVOLVER_SPEC: return createEvolverSpec();
      case MdeoptimisePackage.MULTIPLICITY_REFINEMENT_SPEC: return createMultiplicityRefinementSpec();
      case MdeoptimisePackage.EVOLVER_PARAMETER: return createEvolverParameter();
      case MdeoptimisePackage.PARAMETER_FUNCTION: return createParameterFunction();
      case MdeoptimisePackage.OPTIMISATION_SPEC: return createOptimisationSpec();
      case MdeoptimisePackage.ALGORITHM_VARIATION: return createAlgorithmVariation();
      case MdeoptimisePackage.PROBABILITY_VARIATION: return createProbabilityVariation();
      case MdeoptimisePackage.ALGORITHM_PARAMETERS: return createAlgorithmParameters();
      case MdeoptimisePackage.TERMINATION_CONDITION_PARAMETERS: return createTerminationConditionParameters();
      case MdeoptimisePackage.PARAMETER: return createParameter();
      default:
        throw new IllegalArgumentException("The class '" + eClass.getName() + "' is not a valid classifier");
    }
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public Object createFromString(EDataType eDataType, String initialValue)
  {
    switch (eDataType.getClassifierID())
    {
      case MdeoptimisePackage.EVOLVER_TYPE:
        return createEvolverTypeFromString(eDataType, initialValue);
      default:
        throw new IllegalArgumentException("The datatype '" + eDataType.getName() + "' is not a valid classifier");
    }
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  @Override
  public String convertToString(EDataType eDataType, Object instanceValue)
  {
    switch (eDataType.getClassifierID())
    {
      case MdeoptimisePackage.EVOLVER_TYPE:
        return convertEvolverTypeToString(eDataType, instanceValue);
      default:
        throw new IllegalArgumentException("The datatype '" + eDataType.getName() + "' is not a valid classifier");
    }
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public Optimisation createOptimisation()
  {
    OptimisationImpl optimisation = new OptimisationImpl();
    return optimisation;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public BasePathSpec createBasePathSpec()
  {
    BasePathSpecImpl basePathSpec = new BasePathSpecImpl();
    return basePathSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MetaModelSpec createMetaModelSpec()
  {
    MetaModelSpecImpl metaModelSpec = new MetaModelSpecImpl();
    return metaModelSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ModelPathSpec createModelPathSpec()
  {
    ModelPathSpecImpl modelPathSpec = new ModelPathSpecImpl();
    return modelPathSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ObjectiveInterpreterSpec createObjectiveInterpreterSpec()
  {
    ObjectiveInterpreterSpecImpl objectiveInterpreterSpec = new ObjectiveInterpreterSpecImpl();
    return objectiveInterpreterSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ConstraintInterpreterSpec createConstraintInterpreterSpec()
  {
    ConstraintInterpreterSpecImpl constraintInterpreterSpec = new ConstraintInterpreterSpecImpl();
    return constraintInterpreterSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ModelInitialiserSpec createModelInitialiserSpec()
  {
    ModelInitialiserSpecImpl modelInitialiserSpec = new ModelInitialiserSpecImpl();
    return modelInitialiserSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public RulegenSpec createRulegenSpec()
  {
    RulegenSpecImpl rulegenSpec = new RulegenSpecImpl();
    return rulegenSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public RulegenNode createRulegenNode()
  {
    RulegenNodeImpl rulegenNode = new RulegenNodeImpl();
    return rulegenNode;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public RulegenEdge createRulegenEdge()
  {
    RulegenEdgeImpl rulegenEdge = new RulegenEdgeImpl();
    return rulegenEdge;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ReportInterpreterSpec createReportInterpreterSpec()
  {
    ReportInterpreterSpecImpl reportInterpreterSpec = new ReportInterpreterSpecImpl();
    return reportInterpreterSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EvolverSpec createEvolverSpec()
  {
    EvolverSpecImpl evolverSpec = new EvolverSpecImpl();
    return evolverSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MultiplicityRefinementSpec createMultiplicityRefinementSpec()
  {
    MultiplicityRefinementSpecImpl multiplicityRefinementSpec = new MultiplicityRefinementSpecImpl();
    return multiplicityRefinementSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EvolverParameter createEvolverParameter()
  {
    EvolverParameterImpl evolverParameter = new EvolverParameterImpl();
    return evolverParameter;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ParameterFunction createParameterFunction()
  {
    ParameterFunctionImpl parameterFunction = new ParameterFunctionImpl();
    return parameterFunction;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public OptimisationSpec createOptimisationSpec()
  {
    OptimisationSpecImpl optimisationSpec = new OptimisationSpecImpl();
    return optimisationSpec;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public AlgorithmVariation createAlgorithmVariation()
  {
    AlgorithmVariationImpl algorithmVariation = new AlgorithmVariationImpl();
    return algorithmVariation;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public ProbabilityVariation createProbabilityVariation()
  {
    ProbabilityVariationImpl probabilityVariation = new ProbabilityVariationImpl();
    return probabilityVariation;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public AlgorithmParameters createAlgorithmParameters()
  {
    AlgorithmParametersImpl algorithmParameters = new AlgorithmParametersImpl();
    return algorithmParameters;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public TerminationConditionParameters createTerminationConditionParameters()
  {
    TerminationConditionParametersImpl terminationConditionParameters = new TerminationConditionParametersImpl();
    return terminationConditionParameters;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public Parameter createParameter()
  {
    ParameterImpl parameter = new ParameterImpl();
    return parameter;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public EvolverType createEvolverTypeFromString(EDataType eDataType, String initialValue)
  {
    EvolverType result = EvolverType.get(initialValue);
    if (result == null) throw new IllegalArgumentException("The value '" + initialValue + "' is not a valid enumerator of '" + eDataType.getName() + "'");
    return result;
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public String convertEvolverTypeToString(EDataType eDataType, Object instanceValue)
  {
    return instanceValue == null ? null : instanceValue.toString();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @generated
   */
  public MdeoptimisePackage getMdeoptimisePackage()
  {
    return (MdeoptimisePackage)getEPackage();
  }

  /**
   * <!-- begin-user-doc -->
   * <!-- end-user-doc -->
   * @deprecated
   * @generated
   */
  @Deprecated
  public static MdeoptimisePackage getPackage()
  {
    return MdeoptimisePackage.eINSTANCE;
  }

} //MdeoptimiseFactoryImpl
