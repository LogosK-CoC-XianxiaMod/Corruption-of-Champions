package classes.BodyParts {

public class Gills extends BodyPart {
	public static const NONE:int                   = 0;
	public static const ANEMONE:int                = 1;
	public static const FISH:int                   = 2;
	public static const GILLS_IN_TENTACLE_LEGS:int = 3;
	// Don't forget to add new types in DebugMenu.as list GILLS_TYPE_CONSTANTS
	
	public function Gills() {
		super(null, null);
	}
}
}
