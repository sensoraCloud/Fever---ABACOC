import java.nio.file.*;


public class DataSet {
	private int total_files;
	
	public DataSet(String filename, boolean randomised){
		this.total_files = FileHandler.LoadData(filename, randomised);
	}
	
	public int getTotalFiles(){
		return this.total_files;
	}
	
	public DataFile getFile(int index){
		Path pathfile = FileHandler.getPaths().get(index);
		return new DataFile(pathfile);
	}
}
