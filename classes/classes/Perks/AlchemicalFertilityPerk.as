/**
 * Created by aimozg on 27.01.14.
 */
package classes.Perks
{
	import classes.PerkClass;
	import classes.PerkType;

	public class AlchemicalFertilityPerk extends PerkType
	{

		override public function desc(params:PerkClass = null):String
		{
			var output:String = "Increases fertility by " + params.value2 + "% and pregnancy speed by " + int(100 * params.value1) + "%, and makes your periods of heat stronger by " + int(100 * params.value3) + "%.";
			if (params.value3 >= 10) output += " In addition, upon giving birth you will spontaneously go into heat!";
			return output;
		}

		public function AlchemicalFertilityPerk()
		{
			super("Alchemical Fertility", "Alchemical Fertility", "The concoctions Tamani's been pumping you full of have altered you to be better able to bear her daughters.", null, true);
		}
		override public function keepOnAscension(respec:Boolean = false):Boolean 
		{
			return false;
		}
	}
}
