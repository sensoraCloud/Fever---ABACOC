import java.util.ArrayList;


public class ABACOC_Training extends ABACOC<ABACOC_Model> {

	private int iter;

	public ABACOC_Training(){
		super();
		this.iter = 0;
	}

	@Override
	public ABACOC_Model execute(ABACOC_Model model, ArrayList<double []> video, int className) {
		double [] sample = null;
		int class_index = 0;

		if(ABACOC_Parameters.add_derivative){
			video = this.mergeVideos(video, this.diff(video));
		}

		if(this.iter == 0){

			//Add the class of the video
			model.ordered_class.add(className);
			model.num_clases = 1;

			//Kdt with merged video dim
			int dim = video.get(0).length;
			model.initKDT(dim);
			
			//Normalise data
			if(!ABACOC_Parameters.nomalised_frame){
				sample = video.get(0);
			}else{
				sample = this.normaliseSample(video.get(0));
			}

			//Add the ball
			ABACOC_Ball ball = new ABACOC_Ball(sample);
			ball.updateClassBall(0);

			//Put ball in kdt
			model.insert(sample,  ball);			
		}

		//Number of frames
		int T = video.size();

		class_index = model.getClassIndex(className);
		if(class_index == -1){ //The element does not exist in the list		
			model.ordered_class.add(className);
			model.num_clases ++;
			class_index = model.ordered_class.size() - 1;
		}
		
		
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
