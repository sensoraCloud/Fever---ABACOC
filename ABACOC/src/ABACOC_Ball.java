import java.util.ArrayList;
import java.util.Arrays;

public class ABACOC_Ball {


	private ArrayList<Integer> class_counts;
	public double radious;
	public int n_err;
	private int num_elements;
	private double [] center;


	public ABACOC_Ball(double [] center){
		this.class_counts = new ArrayList<Integer>();
		this.num_elements = 0;
		this.n_err = 0;
		this.radious = ABACOC_Parameters.eps;
		this.center = center;
	}

	public void updateClassBall(int class_index){
		if(this.class_counts.isEmpty() && class_index == 0){
			this.class_counts.add(0);
		}else{

			if(class_index > this.class_counts.size() - 1){
				int initial_size = this.class_counts.size();
				for (int i = 0; i < class_index - initial_size + 1; i++) {
					this.class_counts.add(0);
				}
			}
		}

		this.class_counts.set(class_index, this.class_counts.get(class_index) + 1);
		this.num_elements++;
		this.updateRadious(class_index);
	}

	public int getNumElements(){
		return this.num_elements;
	}

	private void updateRadious(int class_index){
		if(class_index != getMaxIndex()){
			this.n_err++;
			this.radious = ABACOC_Parameters.eps * Math.pow(this.n_err, -(1.0/(2.0 + ABACOC_Parameters.intrinsicDimension)));
		}
	}

	public int getMaxIndex(){
		int max = this.class_counts.get(0);
		int index = 0;
		for (int i = 1; i < this.class_counts.size(); i++) {
			if(this.class_counts.get(i) > max){
				max = this.class_counts.get(i);
				index = i;
			}
		}

		return index;
	}

	public boolean isInsideBall(double [] sample){
		double distance = 0.0;
		for (int i = 0; i < sample.length; i++) {
			distance = distance  +  Math.pow(this.center[i] - sample[i],2);
		}
		distance = Math.sqrt(distance);
		return (distance < this.radious);
	}


	public double [] getClassProbability(int number_of_classes){
		double [] class_probabilities = new double[number_of_classes];
		Arrays.fill(class_probabilities, 0.0);
		int class_count_size = this.class_counts.size();
		
		//The size of class_counts cannot be bigger than the size of class_probabilities
		//Otherwise Error in code
		
		for (int i = 0; i < number_of_classes; i++) {
			if(i < class_count_size){
				class_probabilities[i] = (this.class_counts.get(i) + 1.0)/((double)this.num_elements +  (double)number_of_classes);
			}else{
				class_probabilities[i] = 1.0/((double)number_of_classes + (double)this.num_elements);
			}
		}
			
			
		double sum = 0;
		for(int i = 0; i< class_probabilities.length; i++){
			sum += class_probabilities[i];
		}
		
		if(sum < 0.99){
		 System.out.print("asdfgadsf");
		}
		
		return class_probabilities;
	}
}
