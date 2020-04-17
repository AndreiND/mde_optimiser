package uk.ac.kcl.inf.mdeoptimiser.interfaces.cli

import com.google.inject.Inject
import com.google.inject.Injector
import com.google.inject.Provider
import java.io.File
import java.util.Date
import org.apache.commons.cli.BasicParser
import org.apache.commons.cli.CommandLine
import org.apache.commons.cli.HelpFormatter
import org.apache.commons.cli.Option
import org.apache.commons.cli.Options
import org.apache.commons.cli.ParseException
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.resource.ResourceSet
import uk.ac.kcl.inf.mdeoptimiser.languages.MoptStandaloneSetup
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.Optimisation
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.output.MDEOBatch
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.output.MDEOResultsOutput
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.OptimisationInterpreter
import java.nio.file.Paths

class Run {
	
	static val Injector injector = new MoptStandaloneSetup().createInjectorAndDoEMFRegistration()
	
	@Inject
	Provider<ResourceSet> resourceSetProvider
	
	Options commandLineOptions;
	
	/**
	 * Static method invoked by the MDEOptimiser launch configuration
	 * @param the configured mopt file path to run the optimisation from
	 */
	def static void main(String[] args){
		val app = injector.getInstance(Run)
		
		
		var parser = new BasicParser();
		var CommandLine command = null
		
		try {
						
			command = parser.parse(app.getCommandLineOptions, args);
						
			var String projectPath = command.getOptionValue("projectPath")
			var String moptPath = command.getOptionValue("moptPath")
			
			if(command.hasOption("batch")){
				var int batchId = Integer.parseInt(command.getOptionValue("batch"))
				
				app.run(projectPath, moptPath, batchId)
				
			} else {
				app.run(projectPath, moptPath)
			}
			
		} catch (ParseException e) {
			app.help();
			System.exit(0);
		}

	}
	
	def void help(){
		var formatter = new HelpFormatter();
		
		var header = "Run MOPT specs from the command line.\n\n";
 		var footer = "\nPlease report issues at https://github.com/mde-optimiser/mde_optimiser/issues";
		
		formatter.printHelp("mdeo", header, this.getCommandLineOptions, footer, true)
		
	}
	
	def Options getCommandLineOptions(){
		
		if(this.commandLineOptions === null) {
			
			this.commandLineOptions = new Options()
			
			var projectPath = new Option("p", "projectPath", true, "use given path as the root of the tool" );
 			projectPath.setRequired(true);
 			projectPath.setArgs(1)
			
			var moptPath = new Option("m", "moptPath", true, "use given MOPT configuration file");
 			moptPath.setRequired(true);
			moptPath.setArgs(1)
			
			commandLineOptions.addOption(projectPath)
			commandLineOptions.addOption(moptPath)
			commandLineOptions.addOption("b", "batch", true, "run a single batch with this numeric ID")
		}
		
		return this.commandLineOptions	
	}
	
	def void run(String moptProjectPath, String configuredMoptFilePath){
		this.run(moptProjectPath, configuredMoptFilePath, null)
	}
	
	def void run(String moptProjectPath, String configuredMoptFilePath, Integer batch){
		
		if (configuredMoptFilePath === null || configuredMoptFilePath.empty) {
			println("Received a null or empty mopt file path.")
			
			return

		} else {

			if(resourceSetProvider === null){
				println("Empty ResourceSetProvider")
			}
			
			val moptFile = new File(configuredMoptFilePath);
			
			if(moptFile.exists) {
				
				val resource = resourceSetProvider.get().getResource(URI.createFileURI(moptFile.getAbsolutePath()), true)
				val optimisationModel = resource.contents.head as Optimisation
				
				val mdeoResultsOutput = new MDEOResultsOutput(new Date(), Paths.get(moptProjectPath), 
					Paths.get(configuredMoptFilePath), optimisationModel);	
				
				if(optimisationModel !== null){
					if(batch === null) {
						
						//Run all the batches from the MOPT file
						
						var experimentId = 0;
		            	do {	      				
		            		//TODO Output generated mutation operators for each experiment? or each batch?
		            		mdeoResultsOutput.logBatch(runBatch(moptProjectPath, optimisationModel, experimentId, false))
		            		experimentId++
						
						} while(experimentId < optimisationModel.solver.algorithmBatches);
					} else {
						
						//Run a specific batch only
		            	mdeoResultsOutput.logBatch(runBatch(moptProjectPath, optimisationModel, batch, true))
					}

	            	mdeoResultsOutput.saveOutcome(batch);
	            }
			
			} else {
				println("Could not find selected mopt file: " + configuredMoptFilePath)
			}
		}
	}
	
	def MDEOBatch runBatch(String moptProjectPath, Optimisation optimisationModel, Integer batch, boolean singleBatch){
						
			var optimisationInterpreter = new OptimisationInterpreter(moptProjectPath, optimisationModel);
	            		
    		val startTime = System.nanoTime;
    		
    		val optimisationOutcome = optimisationInterpreter.start();
    		
    		val endTime = System.nanoTime;
    		
    		val experimentDuration = (endTime - startTime) / 1000000
			
			var generatedRules = optimisationInterpreter.rulegenOperators;
			
			return new MDEOBatch(batch, experimentDuration, optimisationOutcome, generatedRules, singleBatch)
	}
	
}