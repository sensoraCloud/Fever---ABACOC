import java.util.ArrayList;
import java.util.Arrays;



public class ABACOC_Predict extends ABACOC<ABACOC_Class>{

	public int predict(ABACOC_Model model, ArrayList<double[]> video){
		return execute(model, video, 0).getClass_name();
	}
	
	@Override
	public ABACOC_Class execute(ABACOC_Model model, ArrayList<double[]> video, int dummy) {
		double [] sample = null;
		double [] class_probability = null;

		if(ABACOC_Parameters.add_derivative){
			video = this.mergeVideos(video, this.diff(video));
		}

		//Number of frames
		int T = video.size();
		
		double [] class_score = new double[model.num_clases];
		Arrays.fill(class_score, 0.0);

		for (int t = 0; t < T; t++) {

			//Here t is 1
			if(!ABACOC_Parameters.nomalised_frame){
				sample = video.get(t);
			}else{
				sample = this.normaliseSample(video.get(t));
			}

			//Searching the nearest ball in the kdt
			ABACOC_Ball current_ball =  model.search(sample);
			
			
			//Calculate the scores
			class_probability = current_ball.getClassProbability(model.num_clases);
			for (int i = 0; i < model.num_clases; i++) {
				class_score[i] += Math.log(class_probability[i]);
			}
		}
		
		int max_score_index = this.getMaxScore(class_score);
		return new ABACOC_Class(model.ordered_class.get(max_score_index));
	}

}