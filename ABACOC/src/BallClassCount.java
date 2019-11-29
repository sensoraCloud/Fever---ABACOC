
public class BallClassCount {
	private int class_name;
	private int counter;
	
	public BallClassCount(int class_name, int counter){
		this.class_name = class_name;
		this.counter = counter;
	}
	
	public BallClassCount(int class_name){
		this(class_name, 0);
	}
	
	public int getId() {
		return class_name;
	}

	public int getCounter() {
		return counter;
	}
	
	public void increaseCounter(){
		this.counter ++;
	}

	
	
}
