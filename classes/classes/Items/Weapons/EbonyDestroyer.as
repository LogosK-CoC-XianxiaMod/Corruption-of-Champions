package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class EbonyDestroyer extends Weapon
	{
		public function EbonyDestroyer()
		{
			super(
				"EBNYBlade","Ebony Destroyer","ebony destroyer","an ebony destroyer","slash",62,2480,
				"This massive weapon, made of the darkest metal, seems to seethe with unseen malice. Its desire to destroy and damn the pure is so strong that it’s wielder must be wary, lest the blade take control of their body to fulfill its gruesome desires.",
				"Large"
			);
		}
		override public function get attack():Number {
			var strMod:int = Math.floor(Math.min(game.player.str, 150)) / 50;
			var boost:int = (6 * strMod) + 5;
			boost += (game.player.cor - 80 / 3);
			return (5 + boost);
		}

	}

}