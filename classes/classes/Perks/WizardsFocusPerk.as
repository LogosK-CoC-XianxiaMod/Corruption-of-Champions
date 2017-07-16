/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class WizardsFocusPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			return "Increases your spell effect modifier by " + params.value1 * 100 + "%.";
		}

		public function WizardsFocusPerk()
		{
			super("Wizard's Focus", "Wizard's Focus",
					"Your wizard's weapon grants you additional focus, increasing your spells power.");
		}
		
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return true;
		}		
	}
}