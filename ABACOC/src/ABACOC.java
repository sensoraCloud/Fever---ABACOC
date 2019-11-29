import java.util.ArrayList;


public abstract class ABACOC<T extends ABACOC_Element> {
	
	public abstract T execute(ABACOC_Model model, ArrayList<double[]> video, int y);
	
	public ArrayList<double []> diff(ArrayList<double []> sample){
		ArrayList<double []> diff = new ArrayList<double []>();
		for (int i = 0; i < sample.size() - 1; i++) {
			diff.add(calculate_diff(sample.get(i + 1), sample.get(i)));
		}
		return diff;
	}
	
	private double[] calculate_diff(double [] sample1, double [] sample2){
		//It does not matter which length we use... both the same
		double [] result = new double[sample1.length];
		
		for(int i = 0; i< result.length; i++){
			result[i] = sample1[i] - sample2[i];
		}
		return result;
	}
	
	
	public ArrayList<double []> mergeVideos(ArrayList<double[]> original, ArrayList<double []> diff){
		ArrayList<double []> new_video = new ArrayList<double []>();
		
		//Skip the first element in the original sample
		for (int i = 1; i < original.size(); i++) {
			double [] newsample = new double[original.get(i).length +  diff.get(i-1).length];
			System.arraycopy(original.get(i), 0, newsample, 0, original.get(i).length);
			System.arraycopy(diff.get(i-1), 0, newsample, original.get(i).length, diff.get(i-1).length);
			new_video.add(newsample);
		}
		return new_video;
	}
	
	
    private double norm(double [] vector) {
        double sum = 0.0;
        for (int i = 0; i < vector.length; i++)
            sum += vector[i]*vector[i];
        return Math.sqrt(sum);
    }
    
    public double [] normaliseSample(double [] sample){
    	double [] normalised = new double [sample.length];
    	double norm = this.norm(sample);
    	
    	for (int i = 0; i < normalised.length; i++) {
			normalised[i] = sample[i]/norm;
		}
    	return normalised;
    }
    
    public int getMaxScore(double [] scores){
    	double max = scores[0];
    	int index = 0;
    	for (int i = 1; i < scores.length; i++) {
			if(scores[i] > max){
				max = scores[i];
				index = i;
			}
		}
    	return index;
    }
    
}
