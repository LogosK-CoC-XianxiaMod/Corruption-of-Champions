/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	
	public class Syth extends Monster
	{
		private function sythBaseAttack():void {
			if (hasStatusEffect(StatusEffects.Lustzerking)) createStatusEffect(StatusEffects.Attacks, 4, 0, 0, 0);
			else createStatusEffect(StatusEffects.Attacks, 2, 0, 0, 0);
			eAttack();
		}
		
		private function sythAttack1():void {
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage *= 2;
			outputText(capitalA + short + " lift it weapon with all his strenght and smash it on your head.");
			if(damage > 0) damage = player.takeDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}
		
		private function sythAttack2():void {
			var damage:Number;
			//return to combat menu when finished
			doNext(game.playerMenu);
			//Blind dodge change
			if(hasStatusEffect(StatusEffects.Blind) && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind attack!\n");
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 83) {
				outputText("The salamander rushes at you, knocking aside your defensive feint and trying to close the distance between you.  He lashes out at your feet with his tail, and you're only just able to dodge the surprise attack.");
				return;
			}
			//Determine if evaded
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 5) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s tail-swipe.\n");
				return;
			}
			//("Misdirection"
			if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 5 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings, you anticipate and sidestep " + a + short + "' tail-swipe.\n");
				return;
			}
			//Determine if cat'ed
			if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 3) {
				outputText("With your incredible flexibility, you squeeze out of the way of a tail-swipe!");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str) - rand(player.tou) - player.armorDef);
			if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 3;
			if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 0.3;
			damage = Math.round(damage);
			//No damage
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				if(rand(player.armorDef + player.tou) < player.armorDef) outputText("The salamander's tail-swipe harmlessly deflects off your armor!");
				else outputText("The salamander's tail-swipe hits you but fails to move or damage you.");
			}
			//Take Damage
			else outputText("The salamander rushes at you, knocking aside your defensive feint and sliding in past your guard.  He lashes out at your feet with his tail, and you can feel the heated wake of the fiery appendage on your ensuing fall toward the now-smouldering grass. ");
			if(damage > 0) {
				if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
			if(damage > 0) damage = player.takeDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}
		
		private function sythAttack3():void{
			outputText("Salamander start drawing symbols in the air toward you.");
			var lustDmg:Number = this.lust / 10 + this.lib / 10 + this.inte / 10;
			lustDmg = Math.round(lustDmg);
			game.dynStats("lus", lustDmg, "resisted", false);
			outputText(" <b>(<font color=\"#ff00ff\">" + lustDmg + "</font>)</b>");
		}
		
		private function sythBerserk():void {
			outputText("Salamander roar and unleash his lustful fury in order to destroy you!\n\n");
			this.weaponAttack += (40 + (40 * (1 + player.newGamePlusMod)));
			createStatusEffect(StatusEffects.Lustzerking,10,0,0,0);
		}
		
		/*private function sythUltimateAttack():void {
			outputText("Salamander ... WIP TEXT !\n\n");
			flames of love covering whole body while Sythril slam into PC? lowers lust if Sythril had any, put cooldown for few turns before he can use it again
		}*/
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					this.weaponAttack -= (40 + (40 * (1 + player.newGamePlusMod)));
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			var choice:Number = rand(6);
			if (choice == 0) {
				if (hasStatusEffect(StatusEffects.Lustzerking)) sythBaseAttack();
				else sythBerserk();
			}
			if (choice == 1) sythAttack1();
			if (choice == 2) sythAttack2();
			if (choice == 3) sythAttack3();
			//if (choice == 4) sythUltimateAttack();//some super cool channeled or not super attack that will be his ace - smth to mix salamanders and demons style xD
			if (choice >= 4) sythBaseAttack();
			combatRoundOver();
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "You are fighting a (literally) smoking hot salamander – a eight foot tall man with crimson scales covering his legs, back, and forearms, with a tail swishing menacingly behind him, ablaze with a red-hot fire.  His white hair accents his sapphire eyes, while his body covers leather armor.  His dual BF Swords are raised to his side, looking for any hole in your guard.";
			if (hasStatusEffect(StatusEffects.Lustzerking))
			{
				str += "\n\n<b>Looking at his posture and gaze indicates that he's currently under effect of some sort of berserking state.</b>";
			}
			return str;
		}
		
		public function Syth() 
		{
			this.a = "the ";
			this.short = "salamander";//Syth(ril)
			this.imageName = "syth";//make him bro-looking/but would he have bro mind or not...up to decide
			this.long = "";
			this.createCock(12,2,CockTypesEnum.DEMON);
			this.createCock(12,2,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 8*12;
			this.hipRating = HIP_RATING_SLENDER;
			this.buttRating = BUTT_RATING_TIGHT;
			this.lowerBody = LOWER_BODY_TYPE_SALAMANDER;
			this.hairColor = "white";
			this.hairLength = 1;
			initStrTouSpeInte(160, 120, 70, 60);
			initLibSensCor(120, 25, 70);
			this.weaponName = "pair of big fucking swords";
			this.weaponVerb= "slash";
			this.weaponAttack = 56 + (12 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "scales";
			this.armorDef = 27 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 300;
			this.additionalXP = 300;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.gems = 40 + rand(12);
			this.drop = new ChainedDrop().
					add(weapons.DBFSWO,1/50).
					add(armors.LEATHRA,1/20).
					add(consumables.SALAMFW,0.7);
			this.wingType = WING_TYPE_BAT_LIKE_LARGE_2;
			this.tailType = TAIL_TYPE_SALAMANDER;
			this.tailRecharge = 0;
			this.createStatusEffect(StatusEffects.Keen, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.str += 48 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 21 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 18 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 6360;
			checkMonster();
		}
		
	}

}