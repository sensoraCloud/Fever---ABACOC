import java.util.ArrayList;
import java.util.List;
import net.sf.javaml.core.kdtree.KDTree;

public class ABACOC_Model implements ABACOC_Element{

	public int num_clases;
	public List <Integer> ordered_class; 	
	public KDTree kdt;
	
	public ABACOC_Model(){
		
		//Init lists and arrays
		this.ordered_class = new ArrayList<Integer>();
		this.num_clases = 0;		
	}
	
	public void initKDT(int dim){
		this.kdt = new KDTree(dim);
	}
	
	
	public void insert(double [] center, ABACOC_Ball ball){
		this.kdt.insert(center, (ABACOC_Ball)ball);
	}
	
	public ABACOC_Ball search(double [] center){
		return (ABACOC_Ball) this.kdt.nearest(center);
	}
	
	public boolean existClassName(int className){
		return this.ordered_class.contains(className);
	}
	
	public int getClassIndex(int className){
		return this.ordered_class.indexOf(className);
	}

	@Override
	public String display() {
		// TODO Auto-generated method stub
		return null;
	}

}
