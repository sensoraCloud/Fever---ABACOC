import java.util.ArrayList;


public class ABACOC_Continuous_Pose_Detection extends ABACOC<ABACOC_Model> {

	private int iter;

	public ABACOC_Continuous_Pose_Detection(){
		super();
		this.iter = 0;
	}

	@Override
	public ABACOC_Model execute(ABACOC_Model model, ArrayList<double []> video) {
		
                double [] sample = null;
		int class_index = 0;

		//Number of frames (in future stream of frames directly)
		int T = video.size();
		
		
		for (int t = 0; t < T; t++) {

			if(this.iter > 0){
				this.iter++;
				//Here t is 1
				if(!ABACOC_Parameters.nomalised_frame){
					sample = video.get(t);
				}else{
					sample = this.normaliseSample(video.get(t));
				}
				
				
				//Searching the nearest ball in the kdt
				ABACOC_Ball current_ball =  model.search(sample);
				
				//If the sample is inside the ball radious 
				if(current_ball.isInsideBall(sample)){ //// CHECK THE ELEMENT HAS CHANGED IN THE KDT!!
					current_ball.updateClassBall(class_index);
				}else{
					//Add the ball
					ABACOC_Ball ball = new ABACOC_Ball(sample);
					ball.updateClassBall(class_index);

					//Put ball in kdt
					model.insert(sample,  ball);
				}
			}else{
				this.iter++;
			}
		}
		return model;
	}

}
