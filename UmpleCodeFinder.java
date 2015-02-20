import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.filechooser.FileNameExtensionFilter;


public class UmpleCodeFinder {
	
	private static JPanel mainPanel;
	
	public UmpleCodeFinder(){

		//Setting GUI aesthetics
		try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		} catch (ClassNotFoundException | InstantiationException
				| IllegalAccessException | UnsupportedLookAndFeelException e) {
			e.printStackTrace();
		}
		
		//Initialize the file selection dialog
		JFileChooser chooser = new JFileChooser();
		chooser.setFileFilter(new FileNameExtensionFilter("Normal Text File (*.txt)", "txt"));
		chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);

		//Open the chooser and perform the appropriate operations
		if (chooser.showOpenDialog(mainPanel) == JFileChooser.APPROVE_OPTION){
			String selected = chooser.getSelectedFile().toString();
			if(selected.endsWith(".txt"))
				System.out.println("\"" + selected + "\"");
			else{
				JOptionPane.showMessageDialog(mainPanel, "Invalid file type. Please select a text file.");
				new UmpleCodeFinder();
			}
		}
	}
	
	public static void main(String[] args){
		new UmpleCodeFinder();
	}
}
