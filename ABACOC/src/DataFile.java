import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Path;
import java.util.ArrayList;


public class DataFile {
	private ArrayList<double []> file;
	private int className;
	
	public DataFile(){		
		this.file = new ArrayList<double []>();
	}
	
	public DataFile(Path path){
		//System.out.println(path.toString());
		int index = path.getParent().getNameCount() -1;
		this.className = Integer.parseInt(path.getParent().getName(index).toString());
		//System.out.println("ClassName: " + this.className);
		this.file = this.inverse(this.ReadFile(path));
	}
	
	public void ReadDataSet(Path path){
		this.file = this.inverse(this.ReadFile(path));
	}
	
	public final int getDimension(){
		return this.file.get(0).length;
	}
	
	public final int getNumberReadings(){
		return this.file.size();
	}
	
	public final double[] getReading(int index){
		return this.file.get(index);
	}
	
	public final ArrayList<double []> getData(){
		return this.file;
	}
	
	public final int getClassName(){
		return this.className;
	}
	
	
	
	
	private ArrayList<double []> inverse(ArrayList<String []> file){
		ArrayList<double []> orderedFile = new ArrayList<double []>();
		int cols = file.get(0).length;
		int rows = file.size();
		
		for(int col = 0; col < cols; col++){
			double [] aux = new double[rows];
			for (int row = 0; row < rows; row++) {
				aux[row] = Double.parseDouble(file.get(row)[col]);
			}
			orderedFile.add(aux);
		}
		return orderedFile;
	}
	
	private ArrayList<String []> ReadFile(Path path){
		ArrayList<String[]> lines = new ArrayList<String[]>();
		try {
			@SuppressWarnings("resource")
			BufferedReader br = new BufferedReader(new FileReader(path.toString()));
			while(br.ready()){
				lines.add(br.readLine().split(","));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return lines;
	}
}
