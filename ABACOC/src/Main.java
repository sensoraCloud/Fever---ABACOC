import java.io.IOException;




public class Main {

	/**
	 * @param args
	 * @throws IOException 
	 */
	
	public void simpleTest(){
		//Load the files
		DataSet ds_train = new DataSet("auslanshort2centered_TestTrain/Train/", true);
		//DataSet ds_train = new DataSet("dataset1/jvowels_TestTrain/Train/", true);
		
		//Create the training model
		ABACOC_Training  abacoc_t = new ABACOC_Training();
		ABACOC_Model model = new ABACOC_Model();
		
		//Training
		for (int i = 0; i < ds_train.getTotalFiles(); i++) {
			DataFile df = ds_train.getFile(i);
			model = abacoc_t.execute(model, df.getData(), df.getClassName());
		}
		
		//Test
		//DataSet ds_test = new DataSet("dataset1/jvowels_TestTrain/Test/", false);
		DataSet ds_test = new DataSet("auslanshort2centered_TestTrain/Test/", false);
		ABACOC_Predict abacoc_p = new ABACOC_Predict();
		int correct_predictions = 0;

		//Running tester
		for (int i = 0; i < ds_test.getTotalFiles(); i++) {
			DataFile df = ds_train.getFile(i);
			int prediction = abacoc_p.predict(model, df.getData());
			if(prediction == df.getClassName()){
				correct_predictions ++;
			}
		}
		
		double accuracy = (correct_predictions / (double)ds_test.getTotalFiles());
		System.out.println("EPS: " +  ABACOC_Parameters.eps +  " Accuracy: " + accuracy);
	}
	
	public void multipleEpsilonTest(){
		double maxEPS = 2.0;
		ABACOC_Parameters.eps = maxEPS;
		while(ABACOC_Parameters.eps > 0.1){
			this.simpleTest();
			ABACOC_Parameters.eps = ABACOC_Parameters.eps - 0.1;
			
		}
		
	}

	
	public static void main(String[] args) throws IOException {
		new Main().multipleEpsilonTest();
	}
		
	

}
