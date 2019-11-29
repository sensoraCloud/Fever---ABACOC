
import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.ArrayList;



public class FileHandler {

	private static ArrayList<Path> paths;	

	public static int LoadData(String filename, boolean randomised){
		try {
			paths = new ArrayList<Path>();
			FileHandler.LoadDataSet(filename);
			if(randomised){
				java.util.Collections.shuffle(paths);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}	
		return FileHandler.paths.size();
	}

	private static void LoadDataSet(final String filename) throws IOException {
		File file = new File(filename);
		if(!file.exists()){
			throw new IOException("File does not exits");
		}else{
			for (File  element : file.listFiles()) {
				if(element.isFile()){
					if(!element.getName().startsWith(".")){
						paths.add(element.toPath());
					}
				}else{
					LoadDataSet(element.toString());
				}
			}	
		}
	}

	public static ArrayList<Path> getPaths(){
		return paths;
	}
}
