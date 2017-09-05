﻿package classes 
{
import classes.Scenes.Places.TelAdre.UmasShop;
import classes.Items.JewelryLib;
import classes.GlobalFlags.kFLAGS;

/**
	 * Character class for player and NPCs. Has subclasses Player and NonPlayer.
	 * @author Yoffy
	 */
	public class Character extends Creature
	{
		//BEARDS! Not used anywhere right now but WHO WANTS A BEARD?
		//Kitteh6660: I want a beard! I'll code in obtainable beard. (DONE!)

		//Used for hip ratings
		public var thickness:Number = 0;
		
		//Body tone i.e. Lithe, stocky, etc
		public var tone:Number = 0;
		
		private var _pregnancyType:int = 0;
		public function get pregnancyType():int { return _pregnancyType; }

		private var _pregnancyIncubation:int = 0;
		public function get pregnancyIncubation():int { return _pregnancyIncubation; }

		private var _buttPregnancyType:int = 0;
		public function get buttPregnancyType():int { return _buttPregnancyType; }

		private var _buttPregnancyIncubation:int = 0;
		public function get buttPregnancyIncubation():int { return _buttPregnancyIncubation; }


		
		//Key items
		public var keyItems:Array;
		
		public function Character()
		{
			keyItems = [];
		}
		
		//Return bonus fertility

		//return total fertility

		
		//Modify femininity!
		public function modFem(goal:Number, strength:Number = 1):String
		{
			var output:String = "";
			var old:String = faceDesc();
			var oldN:Number = femininity;
			var Changed:Boolean = false;
			//If already perfect!
			if (goal == femininity)
				return "";
			//If turning MANLYMAN
			if (goal < femininity && goal <= 50)
			{
				femininity -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (femininity < goal)
					femininity = goal;
				Changed = true;
			}
			//if turning GIRLGIRLY, like duh!
			if (goal > femininity && goal >= 50)
			{
				femininity += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (femininity > goal)
					femininity = goal;
				Changed = true;
			}
			//Fix if it went out of bounds!
			if (findPerk(PerkLib.Androgyny) < 0)
				fixFemininity();
			//Abort if nothing changed!
			if (!Changed)
				return "";
			//See if a change happened!
			if (old != faceDesc())
			{
				//Gain fem?
				if (goal > oldN)
					output = "\n\n<b>Your facial features soften as your body becomes more feminine. (+" + strength + ")</b>";
				if (goal < oldN)
					output = "\n\n<b>Your facial features harden as your body becomes more masculine. (+" + strength + ")</b>";
			}
			//Barely noticable change!
			else
			{
				if (goal > oldN)
					output = "\n\nThere's a tingling in your " + face() + " as it changes imperceptibly towards being more feminine. (+" + strength + ")";
				else if (goal < oldN)
					output = "\n\nThere's a tingling in your " + face() + " as it changes imperciptibly towards being more masculine. (+" + strength + ")";
			}
			return output;
		}
		
		public function modThickness(goal:Number, strength:Number = 1):String
		{
			if (goal == thickness)
				return "";
			//Lose weight fatty!
			if (goal < thickness && goal < 50)
			{
				thickness -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (thickness < goal)
					thickness = goal;
			}
			//Sup tubby!
			if (goal > thickness && goal > 50)
			{
				thickness += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (thickness > goal)
					thickness = goal;
			}
			trace("MOD THICKNESS FIRE");
			//DIsplay 'U GOT FAT'
			if (goal >= thickness && goal >= 50)
				return "\n\nYour center of balance changes a little bit as your body noticeably widens. (+" + strength + " body thickness)";
			//GET THIN BITCH
			else if (goal <= thickness && goal <= 50)
				return "\n\nEach movement feels a tiny bit easier than the last.  Did you just lose a little weight!? (+" + strength + " thin)";
			return "";
		}
		
		public function modTone(goal:Number, strength:Number = 1):String
		{
			if (goal == tone)
				return "";
			//Lose muscle visibility!
			if (goal < tone && goal < 50)
			{
				tone -= strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (tone < goal)
				{
					tone = goal;
					return "\n\nYou've lost some tone, but can't lose any more this way. (-" + strength + " muscle tone)";
				}
			}
			//MOAR hulkness
			if (goal > tone && goal > 50)
			{
				tone += strength;
				//YOUVE GONE TOO FAR! TURN BACK!
				if (tone > goal)
				{
					tone = goal;
					return "\n\nYou've gained some muscle tone, but can't gain any more this way. (+" + strength + " muscle tone)";
				}
			}
			//DIsplay BITCH I WORK OUT
			if (goal >= tone && goal > 50)
				return "\n\nYour body feels a little more solid as you move, and your muscles look slightly more visible. (+" + strength + " muscle tone)";
			//Display DERP I HAVE GIRL MUSCLES
			else if (goal <= tone && goal < 50)
				return "\n\nMoving brings with it a little more jiggle than you're used to.  You don't seem to have gained weight, but your muscles look less visible. (-" + strength + " muscle tone)";
			return "";
		}
		
		//Run this every hour to 'fix' femininity.
		public function fixFemininity():String
		{
			var output:String = "";
			//Genderless/herms share the same bounds
			if (gender == 0 || gender == 3)
			{
				if (femininity < 20)
				{
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					/*if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}*/
					output += "</b>\n";
					femininity = 20;
				}
				else if (femininity > 85)
				{
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 85;
				}
			}
			//GURLS!
			else if (gender == 2)
			{
				if (femininity < 30)
				{
					output += "\n<b>Your incredibly masculine, chiseled features become a little bit softer from your body's changing hormones.";
					/*if (hasBeard())
					{
						output += "  As if that wasn't bad enough, your " + beard() + " falls out too!";
						beardLength = 0;
						beardStyle = 0;
					}*/
					output += "</b>\n";
					femininity = 30;
				}
			}
			//BOIZ!
			else if (gender == 1)
			{
				if (femininity > 70)
				{
					output += "\n<b>You find your overly feminine face loses a little bit of its former female beauty due to your body's changing hormones.</b>\n";
					femininity = 70;
				}
				/*if (femininity > 40 && hasBeard())
				{
					output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
					beardLength = 0;
					beardStyle = 0;
				}*/
			}
			/*if (gender != 1 && hasBeard())
			{
				output += "\n<b>Your beard falls out, leaving you with " + faceDesc() + ".</b>\n";
				beardLength = 0;
				beardStyle = 0;
			}*/
			return output;
		}

	public function hasBeard():Boolean{ return facePart.hasBeard(); }
	public function beard():String{ return facePart.beard(); }
	public function hasMuzzle():Boolean{ return facePart.hasMuzzle(); }
	public function face():String { return facePart.describe(); }
	public function faceDesc():String { return facePart.describeMF(); }
	public function hasLongTail():Boolean { return tail.isLong(); }

		public function isPregnant():Boolean { return _pregnancyType != 0; }

		public function isButtPregnant():Boolean { return _buttPregnancyType != 0; }
	
		//fertility must be >= random(0-beat)
		//If arg == 1 then override any contraceptives and guarantee fertilization
		public function knockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (hasStatusEffect(StatusEffects.Contraceptives) && arg < 1)
				return;
//			if (hasStatusEffect(StatusEffects.GooStuffed)) return; //No longer needed thanks to PREGNANCY_GOO_STUFFED being used as a blocking value
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if (pregnancyIncubation == 0 && totalFertility() + bonus > Math.floor(Math.random() * beat) && hasVagina())
			{
				knockUpForce(type, incubation);
				trace("PC Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
			//Chance for eggs fertilization - ovi elixir and imps excluded!
			if (type != PregnancyStore.PREGNANCY_IMP && type != PregnancyStore.PREGNANCY_OVIELIXIR_EGGS && type != PregnancyStore.PREGNANCY_ANEMONE)
			{
				if (findPerk(PerkLib.SpiderOvipositor) >= 0 || findPerk(PerkLib.BeeOvipositor) >= 0)
				{
					if (totalFertility() + bonus > Math.floor(Math.random() * beat))
					{
						fertilizeEggs();
					}
				}
			}
		}

		//The more complex knockUp function used by the player is defined above
		//The player doesn't need to be told of the last event triggered, so the code here is quite a bit simpler than that in PregnancyStore
		public function knockUpForce(type:int = 0, incubation:int = 0):void
		{
			_pregnancyType = type;
			_pregnancyIncubation = (type == 0 ? 0 : incubation); //Won't allow incubation time without pregnancy type
		}
	
		//fertility must be >= random(0-beat)
		public function buttKnockUp(type:int = 0, incubation:int = 0, beat:int = 100, arg:int = 0):void
		{
			//Contraceptives cancel!
			if (hasStatusEffect(StatusEffects.Contraceptives) && arg < 1)
				return;
			var bonus:int = 0;
			//If arg = 1 (always pregnant), bonus = 9000
			if (arg >= 1)
				bonus = 9000;
			if (arg <= -1)
				bonus = -9000;
			//If unpregnant and fertility wins out:
			if (buttPregnancyIncubation == 0 && totalFertility() + bonus > Math.floor(Math.random() * beat))
			{
				buttKnockUpForce(type, incubation);
				trace("PC Butt Knocked up with pregnancy type: " + type + " for " + incubation + " incubation.");
			}
		}

		//The more complex buttKnockUp function used by the player is defined in Character.as
		public function buttKnockUpForce(type:int = 0, incubation:int = 0):void
		{
			_buttPregnancyType = type;
			_buttPregnancyIncubation = (type == 0 ? 0 : incubation); //Won't allow incubation time without pregnancy type
		}

		public function pregnancyAdvance():Boolean {
			if (_pregnancyIncubation > 0) _pregnancyIncubation--;
			if (_pregnancyIncubation < 0) _pregnancyIncubation = 0;
			if (_buttPregnancyIncubation > 0) _buttPregnancyIncubation--;
			if (_buttPregnancyIncubation < 0) _buttPregnancyIncubation = 0;
			return pregnancyUpdate();
		}

		public function pregnancyUpdate():Boolean { return false; }

		//Create a keyItem
		public function createKeyItem(keyName:String, value1:Number, value2:Number, value3:Number, value4:Number):void
		{
			var newKeyItem:KeyItemClass = new KeyItemClass();
			//used to denote that the array has already had its new spot pushed on.
			var arrayed:Boolean = false;
			//used to store where the array goes
			var keySlot:Number = 0;
			var counter:Number = 0;
			//Start the array if its the first bit
			if (keyItems.length == 0)
			{
				//trace("New Key Item Started Array! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//If it belongs at the end, push it on
			if (keyItems[keyItems.length - 1].keyName < keyName && !arrayed)
			{
				//trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				arrayed = true;
				keySlot = keyItems.length - 1;
			}
			//If it belongs in the beginning, splice it in
			if (keyItems[0].keyName > keyName && !arrayed)
			{
				//trace("New Key Item Belongs at the beginning! " + keyName);
				keyItems.splice(0, 0, newKeyItem);
				arrayed = true;
				keySlot = 0;
			}
			//Find the spot it needs to go in and splice it in.
			if (!arrayed)
			{
				//trace("New Key Item using alphabetizer! " + keyName);
				counter = keyItems.length;
				while (counter > 0 && !arrayed)
				{
					counter--;
					//If the current slot is later than new key
					if (keyItems[counter].keyName > keyName)
					{
						//If the earlier slot is earlier than new key && a real spot
						if (counter - 1 >= 0)
						{
							//If the earlier slot is earlier slot in!
							if (keyItems[counter - 1].keyName <= keyName)
							{
								arrayed = true;
								keyItems.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
						//If the item after 0 slot is later put here!
						else
						{
							//If the next slot is later we are go
							if (keyItems[counter].keyName <= keyName)
							{
								arrayed = true;
								keyItems.splice(counter, 0, newKeyItem);
								keySlot = counter;
							}
						}
					}
				}
			}
			//Fallback
			if (!arrayed)
			{
				//trace("New Key Item Belongs at the end!! " + keyName);
				keyItems.push(newKeyItem);
				keySlot = keyItems.length - 1;
			}
			
			keyItems[keySlot].keyName = keyName;
			keyItems[keySlot].value1 = value1;
			keyItems[keySlot].value2 = value2;
			keyItems[keySlot].value3 = value3;
			keyItems[keySlot].value4 = value4;
			//trace("NEW KEYITEM FOR PLAYER in slot " + keySlot + ": " + keyItems[keySlot].keyName);
		}
		
		//Remove a key item
		public function removeKeyItem(itemName:String):void
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				//trace("ERROR: KeyItem could not be removed because player has no key items.");
				return;
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == itemName)
				{
					keyItems.splice(counter, 1);
					trace("Attempted to remove \"" + itemName + "\" keyItem.");
					counter = 0;
				}
			}
		}
		
		public function addKeyValue(statusName:String, statusValueNum:Number = 1, newNum:Number = 0):void
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return;
					//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				//Find it, change it, quit out
				if (keyItems[counter].keyName == statusName)
				{
					if (statusValueNum < 1 || statusValueNum > 4)
					{
						//trace("ERROR: AddKeyValue called with invalid key value number.");
						return;
					}
					if (statusValueNum == 1)
						keyItems[counter].value1 += newNum;
					if (statusValueNum == 2)
						keyItems[counter].value2 += newNum;
					if (statusValueNum == 3)
						keyItems[counter].value3 += newNum;
					if (statusValueNum == 4)
						keyItems[counter].value4 += newNum;
					return;
				}
			}
			//trace("ERROR: Looking for keyitem '" + statusName + "' to change value " + statusValueNum + ", and player does not have the key item.");
		}
		
		public function keyItemv1(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value1;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv2(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value2;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv3(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value3;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function keyItemv4(statusName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
			{
				return 0;
					//trace("ERROR: Looking for keyItem '" + statusName + "', and player has no key items.");
			}
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == statusName)
					return keyItems[counter].value4;
			}
			//trace("ERROR: Looking for key item '" + statusName + "', but player does not have it.");
			return 0;
		}
		
		public function removeKeyItems():void
		{
			var counter:Number = keyItems.length;
			while (counter > 0)
			{
				counter--;
				keyItems.splice(counter, 1);
			}
		}
		
		public function hasKeyItem(keyName:String):Number
		{
			var counter:Number = keyItems.length;
			//Various Errors preventing action
			if (keyItems.length <= 0)
				return -2;
			while (counter > 0)
			{
				counter--;
				if (keyItems[counter].keyName == keyName)
					return counter;
			}
			return -1;
		}
		
		//Grow

		//BreastCup

		/*OLD AND UNUSED
		   public function breastCupS(rowNum:Number):String {
		   if(breastRows[rowNum].breastRating < 1) return "tiny";
		   else if(breastRows[rowNum].breastRating < 2) return "A";
		   else if(breastRows[rowNum].breastRating < 3) return "B";
		   else if(breastRows[rowNum].breastRating < 4) return "C";
		   else if(breastRows[rowNum].breastRating < 5) return "D";
		   else if(breastRows[rowNum].breastRating < 6) return "DD";
		   else if(breastRows[rowNum].breastRating < 7) return "E";
		   else if(breastRows[rowNum].breastRating < 8) return "F";
		   else if(breastRows[rowNum].breastRating < 9) return "G";
		   else if(breastRows[rowNum].breastRating < 10) return "GG";
		   else if(breastRows[rowNum].breastRating < 11) return "H";
		   else if(breastRows[rowNum].breastRating < 12) return "HH";
		   else if(breastRows[rowNum].breastRating < 13) return "HHH";
		   return "massive custom-made";
		 }*/
		public function viridianChange():Boolean
		{
			var count:int = cockTotal();
			if (count == 0)
				return false;
			while (count > 0)
			{
				count--;
				if (cocks[count].sock == "amaranthine" && cocks[count].cockType != CockTypesEnum.DISPLACER)
					return true;
			}
			return false;
		}
		
		public function hasKnot(arg:int = 0):Boolean
		{
			if (arg > cockTotal() - 1 || arg < 0)
				return false;
			return cocks[arg].hasKnot();
		}


		public function maxHP():Number
		{
			var max:Number = 0;
			max += int(tou * 2 + 50);
			if (tou >= 21) max += Math.round(tou);
			if (tou >= 41) max += Math.round(tou);
			if (tou >= 61) max += Math.round(tou);
			if (tou >= 81) max += Math.round(tou);
			if (tou >= 101) max += Math.round(tou);
			if (tou >= 151) max += Math.round(tou);
			if (tou >= 201) max += Math.round(tou);
			if (tou >= 251) max += Math.round(tou);
			if (tou >= 301) max += Math.round(tou);
			if (tou >= 351) max += Math.round(tou);
			if (tou >= 401) max += Math.round(tou);
			if (tou >= 451) max += Math.round(tou);
			if (tou >= 501) max += Math.round(tou);
			if (tou >= 551) max += Math.round(tou);
			if (tou >= 601) max += Math.round(tou);
			if (tou >= 651) max += Math.round(tou);
			if (tou >= 701) max += Math.round(tou);
			if (tou >= 751) max += Math.round(tou);
			if (tou >= 801) max += Math.round(tou);
			if (tou >= 851) max += Math.round(tou);
			if (tou >= 901) max += Math.round(tou);
			if (tou >= 951) max += Math.round(tou);
			if (game.player.alicornScore() >= 6) max += (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.centaurScore() >= 5) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 10) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 20) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 28) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.gorgonScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.horseScore() >= 4) max += (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.manticoreScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.rhinoScore() >= 4) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.scyllaScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.scyllaScore() >= 7) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.scyllaScore() >= 12) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.unicornScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.RefinedBodyI) >= 0) max += 50;
			if (findPerk(PerkLib.RefinedBodyII) >= 0) max += 50;
			if (findPerk(PerkLib.RefinedBodyIII) >= 0) max += 50;
			if (findPerk(PerkLib.RefinedBodyIV) >= 0) max += 50;
			if (findPerk(PerkLib.RefinedBodyV) >= 0) max += 50;
			if (findPerk(PerkLib.RefinedBodyVI) >= 0) max += 50;
			if (findPerk(PerkLib.TankI) >= 0) max += Math.round(tou*3);
 			if (findPerk(PerkLib.TankII) >= 0) max += Math.round(tou*3);
			if (findPerk(PerkLib.TankIII) >= 0) max += Math.round(tou*3);
			if (findPerk(PerkLib.TankIV) >= 0) max += Math.round(tou*3);
			if (findPerk(PerkLib.TankV) >= 0) max += Math.round(tou*3);
			if (findPerk(PerkLib.TankVI) >= 0) max += Math.round(tou*3);
			if (findPerk(PerkLib.GoliathI) >= 0) max += Math.round(str*2);
 			if (findPerk(PerkLib.GoliathII) >= 0) max += Math.round(str*2);
			if (findPerk(PerkLib.GoliathIII) >= 0) max += Math.round(str*2);
			if (findPerk(PerkLib.GoliathIV) >= 0) max += Math.round(str*2);
			if (findPerk(PerkLib.GoliathV) >= 0) max += Math.round(str*2);
			if (findPerk(PerkLib.GoliathVI) >= 0) max += Math.round(str*2);
			if (findPerk(PerkLib.CheetahI) >= 0) max += Math.round(spe);
 			if (findPerk(PerkLib.CheetahII) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.CheetahIII) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.CheetahIV) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.CheetahV) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.CheetahVI) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ElementalBondFlesh) >= 0) {
				if (hasStatusEffect(StatusEffects.SummonedElementalsAir)) max += 10 * statusEffectv2(StatusEffects.SummonedElementalsAir);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEarth)) max += 10 * statusEffectv2(StatusEffects.SummonedElementalsEarth);
				if (hasStatusEffect(StatusEffects.SummonedElementalsFire)) max += 10 * statusEffectv2(StatusEffects.SummonedElementalsFire);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWater)) max += 10 * statusEffectv2(StatusEffects.SummonedElementalsWater);
				if (hasStatusEffect(StatusEffects.SummonedElementalsIce)) max += 10 * statusEffectv2(StatusEffects.SummonedElementalsIce);
				if (hasStatusEffect(StatusEffects.SummonedElementalsLightning)) max += 10 * statusEffectv2(StatusEffects.SummonedElementalsLightning);
				if (hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) max += 10 * statusEffectv2(StatusEffects.SummonedElementalsDarkness);
			}
			if (findPerk(PerkLib.JobGuardian) >= 0) max += 30;
			if (findPerk(PerkLib.JobMunchkin) >= 0) max += 150;
			if (findPerk(PerkLib.BodyCultivator) >= 0) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulPersonage) >= 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulWarrior) >= 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulScholar) >= 0) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulElder) >= 0) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (findPerk(PerkLib.FleshBodyElderStage) >= 0) {
				if (findPerk(PerkLib.SoulExalt) >= 0) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulOverlord) >= 0) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulTyrant) >= 0) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (findPerk(PerkLib.FleshBodyOverlordStage) >= 0) {
				if (findPerk(PerkLib.SoulKing) >= 0) max += (125 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulEmperor) >= 0) max += (125 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
				if (findPerk(PerkLib.SoulAncestor) >= 0) max += (125 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			}
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) max += (225 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.AscensionHardiness) >= 0) max += perkv1(PerkLib.AscensionHardiness) * 100;
			if (findPerk(PerkLib.ChiReflowDefense) >= 0) max += UmasShop.NEEDLEWORK_DEFENSE_EXTRA_HP;
			max += level * 15;
			if (findPerk(PerkLib.UnlockBody) >= 0) max += level * 15;
			if (findPerk(PerkLib.AscensionUnlockedPotential) >= 0) max += level * 20;
			if (jewelryEffectId == JewelryLib.MODIFIER_HP) max += jewelryEffectMagnitude;
			max *= 1 + (countCockSocks("green") * 0.02);
			max = Math.round(max);
			if (max > 149999) max = 149999;
			return max;
		}
		
		public function maxLust():Number
		{
			var max:Number = 100;
			if (game.player.cowScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.cowScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.demonScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.demonScore() >= 11) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.devilkinScore() >= 7) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.devilkinScore() >= 10) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 20) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 28) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.minotaurScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.minotaurScore() >= 9) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.phoenixScore() >= 5) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.salamanderScore() >= 4) max += (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.sharkScore() >= 9 && game.player.vaginas.length > 0 && game.player.cocks.length > 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.InhumanDesireI) >= 0) max += 20;
			if (findPerk(PerkLib.InhumanDesireII) >= 0) max += 20;
			if (findPerk(PerkLib.InhumanDesireIII) >= 0) max += 20;
			if (findPerk(PerkLib.InhumanDesireIV) >= 0) max += 20;
			if (findPerk(PerkLib.InhumanDesireV) >= 0) max += 20;
			if (findPerk(PerkLib.InhumanDesireVI) >= 0) max += 20;
			if (findPerk(PerkLib.DemonicDesireI) >= 0) max += Math.round(lib);
			if (findPerk(PerkLib.DemonicDesireII) >= 0) max += Math.round(lib);
			if (findPerk(PerkLib.DemonicDesireIII) >= 0) max += Math.round(lib);
			if (findPerk(PerkLib.DemonicDesireIV) >= 0) max += Math.round(lib);
			if (findPerk(PerkLib.DemonicDesireV) >= 0) max += Math.round(lib);
			if (findPerk(PerkLib.DemonicDesireVI) >= 0) max += Math.round(lib);
			if (findPerk(PerkLib.BasicSelfControl) >= 0) max += 15;
			if (findPerk(PerkLib.HalfStepToImprovedSelfControl) >= 0) max += 25;
			if (findPerk(PerkLib.ImprovedSelfControl) >= 0) max += 40;
			if (findPerk(PerkLib.HalfStepToAdvancedSelfControl) >= 0) max += 60;
			if (findPerk(PerkLib.AdvancedSelfControl) >= 0) max += 100;
			if (findPerk(PerkLib.HalfStepToSuperiorSelfControl) >= 0) max += 160;
			if (findPerk(PerkLib.SuperiorSelfControl) >= 0) max += 250;
			if (findPerk(PerkLib.HalfStepToPeerlessSelfControl) >= 0) max += 350;
			if (findPerk(PerkLib.PeerlessSelfControl) >= 0) max += 500;
			if (findPerk(PerkLib.ElementalBondUrges) >= 0) {
				if (hasStatusEffect(StatusEffects.SummonedElementalsAir)) max += 1 * statusEffectv2(StatusEffects.SummonedElementalsAir);
				if (hasStatusEffect(StatusEffects.SummonedElementalsEarth)) max += 1 * statusEffectv2(StatusEffects.SummonedElementalsEarth);
				if (hasStatusEffect(StatusEffects.SummonedElementalsFire)) max += 1 * statusEffectv2(StatusEffects.SummonedElementalsFire);
				if (hasStatusEffect(StatusEffects.SummonedElementalsWater)) max += 1 * statusEffectv2(StatusEffects.SummonedElementalsWater);
				if (hasStatusEffect(StatusEffects.SummonedElementalsIce)) max += 1 * statusEffectv2(StatusEffects.SummonedElementalsIce);
				if (hasStatusEffect(StatusEffects.SummonedElementalsLightning)) max += 1 * statusEffectv2(StatusEffects.SummonedElementalsLightning);
				if (hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) max += 1 * statusEffectv2(StatusEffects.SummonedElementalsDarkness);
			}
			if (findPerk(PerkLib.BroBody) >= 0 || findPerk(PerkLib.BimboBody) >= 0 || findPerk(PerkLib.FutaForm) >= 0) max += 20;
			if (findPerk(PerkLib.OmnibusGift) >= 0) max += 15;
			if (findPerk(PerkLib.JobCourtesan) >= 0) max += 20;
			if (findPerk(PerkLib.JobMunchkin) >= 0) max += 50;
			if (findPerk(PerkLib.JobSeducer) >= 0) max += 10;
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) max += (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.AscensionDesires) >= 0) max += perkv1(PerkLib.AscensionDesires) * 10;
			if (findPerk(PerkLib.UnlockId) >= 0) max += level;
			if (findPerk(PerkLib.AscensionUnlockedPotential2ndStage) >= 0) max += level * 2;
			if (max > 9999) max = 9999;
			return max;
		}
		
		public function maxFatigue():Number
		{
			var max:Number = 100;
			if (game.player.alicornScore() >= 6) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 20) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.dragonScore() >= 28) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.foxScore() >= 7) max += (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.kitsuneScore() >= 5 && game.player.tailCount >= 2 && game.player.tailCount < 9) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.kitsuneScore() >= 12 && game.player.tailCount == 9) max += (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.lizardScore() >= 4) max += (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (game.player.unicornScore() >= 5) max += (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.ArchersStaminaI) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaII) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaIII) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaIV) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaV) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.ArchersStaminaVI) >= 0) max += Math.round(spe);
			if (findPerk(PerkLib.DancersVitalityI) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityII) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityIII) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityIV) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityV) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.DancersVitalityVI) >= 0) max += Math.round(spe*1.5);
			if (findPerk(PerkLib.NaturesSpringI) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringII) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringIII) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringIV) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringV) >= 0) max += 20;
			if (findPerk(PerkLib.NaturesSpringVI) >= 0) max += 20;
			if (findPerk(PerkLib.BasicEndurance) >= 0) max += 30;
			if (findPerk(PerkLib.HalfStepToImprovedEndurance) >= 0) max += 50;
			if (findPerk(PerkLib.ImprovedEndurance) >= 0) max += 80;
			if (findPerk(PerkLib.HalfStepToAdvancedEndurance) >= 0) max += 120;
			if (findPerk(PerkLib.AdvancedEndurance) >= 0) max += 200;
			if (findPerk(PerkLib.HalfStepToSuperiorEndurance) >= 0) max += 320;
			if (findPerk(PerkLib.SuperiorEndurance) >= 0) max += 500;
			if (findPerk(PerkLib.HalfStepToPeerlessEndurance) >= 0) max += 700;
			if (findPerk(PerkLib.PeerlessEndurance) >= 0) max += 1000;
			if (findPerk(PerkLib.JobHunter) >= 0) max += 50;
			if (findPerk(PerkLib.JobMunchkin) >= 0) max += 100;
			if (findPerk(PerkLib.JobRanger) >= 0) max += 5;
			if (findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0) max += 600;
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) max += 150;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) max += 900;
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) max += (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));
			if (findPerk(PerkLib.AscensionEndurance) >= 0) max += perkv1(PerkLib.AscensionEndurance) * 30;
			if (jewelryEffectId == JewelryLib.MODIFIER_MP) max += jewelryEffectMagnitude;
			max += level * 5;
			if (findPerk(PerkLib.UnlockBody2ndStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.AscensionUnlockedPotential) >= 0) max += level * 6;
			if (max > 29999) max = 29999;
			return max;
		}
		
		public function maxSoulforce():Number
		{
			var max:Number = 50;
			if (game.player.alicornScore() >= 6) max += (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));//przenieść do mnożnika?
			if (game.player.unicornScore() >= 5) max += (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL]));//przenieść do mnożnika?
			if (hasPerk(PerkLib.DemonicLethicite)) max += Math.round(lib);
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 3) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 4) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 5) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 6) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 7) max += 40;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 8) max += 40;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 9) max += 40;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 10) max += 50;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 11) max += 50;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 12) max += 50;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 13) max += 60;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 14) max += 60;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 15) max += 60;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 16) max += 70;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 17) max += 70;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 18) max += 70;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 19) max += 80;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 20) max += 80;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 21) max += 80;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 22) max += 90;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 23) max += 90;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 24) max += 90;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 25) max += 100;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 26) max += 100;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 27) max += 100;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 28) max += 110;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 29) max += 110;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 30) max += 110;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 31) max += 120;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 32) max += 120;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 33) max += 120;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 34) max += 130;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 35) max += 130;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 36) max += 130;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 37) max += 140;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 38) max += 140;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 39) max += 140;
			if (findPerk(PerkLib.InsightfulResourcesI) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesII) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesIII) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesIV) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesV) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.InsightfulResourcesVI) >= 0) max += Math.round(wis*3);
			if (findPerk(PerkLib.PrestigeJobSoulArcher) >= 0) max += 1000;
			if (findPerk(PerkLib.PrestigeJobSeer) >= 0) max += 500;
			if (findPerk(PerkLib.AscensionSoulPurity) >= 0) max += perkv1(PerkLib.AscensionSoulPurity) * 50;
			if (findPerk(PerkLib.DaoistCultivator) >= 0) max += 25;
			if (findPerk(PerkLib.DaoistApprenticeStage) >= 0) {
				if (findPerk(PerkLib.SoulApprentice) >= 0) max += 30;
				if (findPerk(PerkLib.SoulPersonage) >= 0) max += 30;
				if (findPerk(PerkLib.SoulWarrior) >= 0) max += 30;
			}
			if (findPerk(PerkLib.DaoistWarriorStage) >= 0) {
				if (findPerk(PerkLib.SoulSprite) >= 0) max += 40;
				if (findPerk(PerkLib.SoulScholar) >= 0) max += 40;
				if (findPerk(PerkLib.SoulElder) >= 0) max += 40;
			}
			if (findPerk(PerkLib.DaoistElderStage) >= 0) {
				if (findPerk(PerkLib.SoulExalt) >= 0) max += 50;
				if (findPerk(PerkLib.SoulOverlord) >= 0) max += 50;
				if (findPerk(PerkLib.SoulTyrant) >= 0) max += 50;
			}
			if (findPerk(PerkLib.DaoistOverlordStage) >= 0) {
				if (findPerk(PerkLib.SoulKing) >= 0) max += 60;
				if (findPerk(PerkLib.SoulEmperor) >= 0) max += 60;
				if (findPerk(PerkLib.SoulAncestor) >= 0) max += 60;
			}
			if (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] > 0) max += flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING];//+310
			if (jewelryEffectId == JewelryLib.MODIFIER_SF) max += jewelryEffectMagnitude;//+20
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) {//4105-5105 soulforce na razie przed liczeniem mnożnika jest
				var multimax:Number = 1;
				if (game.player.dragonScore() >= 20) multimax += 0.1;
				if (game.player.dragonScore() >= 28) multimax += 0.1;
				if (game.player.kitsuneScore() >= 5 && game.player.tailCount >= 2 && game.player.tailCount < 9) multimax += 0.2;
				if (game.player.kitsuneScore() >= 12 && game.player.tailCount == 9) multimax += 0.4;
				if (findPerk(PerkLib.HistoryCultivator) >= 0 || findPerk(PerkLib.PastLifeCultivator) >= 0) multimax += 0.1;
				if (findPerk(PerkLib.JobMunchkin) >= 0) multimax += 0.1;
				if (findPerk(PerkLib.Dantain) >= 0) {
					if (findPerk(PerkLib.JobSoulCultivator) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulApprentice) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulPersonage) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulWarrior) >= 0) multimax += 0.1;
					if (findPerk(PerkLib.SoulSprite) >= 0) multimax += 0.15;
					if (findPerk(PerkLib.SoulScholar) >= 0) multimax += 0.15;
					if (findPerk(PerkLib.SoulElder) >= 0) multimax += 0.15;
					if (findPerk(PerkLib.SoulExalt) >= 0) multimax += 0.2;
					if (findPerk(PerkLib.SoulOverlord) >= 0) multimax += 0.2;
					if (findPerk(PerkLib.SoulTyrant) >= 0) multimax += 0.2;
					if (findPerk(PerkLib.SoulKing) >= 0) multimax += 0.25;
					if (findPerk(PerkLib.SoulEmperor) >= 0) multimax += 0.25;
					if (findPerk(PerkLib.SoulAncestor) >= 0) multimax += 0.25;
				}
				if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) multimax += 0.1;
				if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) multimax += 0.15;
				//if (flags[kFLAGS.UNLOCKED_MERIDIANS] > 0) multimax += flags[kFLAGS.UNLOCKED_MERIDIANS] * 0.05;
				//if (findPerk(PerkLib.Ascension) >= 0) multimax += perkv1(PerkLib.Ascension) * 0.01;
				max *= multimax;
			}
			if (findPerk(PerkLib.UnlockMind2ndStage) >= 0) max += level * 5;
			if (findPerk(PerkLib.AscensionUnlockedPotential2ndStage) >= 0) max += level * 6;
			max = Math.round(max);
			if (max > 79999) max = 79999;
			return max;
		}
		
		public function maxWrath():Number
		{
			var max:Number = 100;
			if (findPerk(PerkLib.DoubleAttack) >= 0) max += 10;
			if (findPerk(PerkLib.TripleAttack) >= 0) max += 10;
			if (findPerk(PerkLib.QuadrupleAttack) >= 0) max += 10;
			if (findPerk(PerkLib.PentaAttack) >= 0) max += 10;
			if (findPerk(PerkLib.HexaAttack) >= 0) max += 10;
			if (findPerk(PerkLib.DoubleAttackLarge) >= 0) max += 20;
			if (findPerk(PerkLib.TripleAttackLarge) >= 0) max += 20;
			if (findPerk(PerkLib.JobBarbarian) >= 0) max += 20;
			if (findPerk(PerkLib.JobDervish) >= 0) max += 20;
			if (findPerk(PerkLib.JobWarlord) >= 0) max += 20;
			if (findPerk(PerkLib.JobWarrior) >= 0) max += 10;
			if (findPerk(PerkLib.Berzerker) >= 0) max += 100;
			if (findPerk(PerkLib.Lustzerker) >= 0) max += 100;
			if (findPerk(PerkLib.PrestigeJobBerserker) >= 0) max += 200;
			if (findPerk(PerkLib.Rage) >= 0) max += 200;
			if (findPerk(PerkLib.Anger) >= 0) max += 200;
			if (findPerk(PerkLib.UnlockId2ndStage) >= 0) max += level;
			if (findPerk(PerkLib.AscensionUnlockedPotential2ndStage) >= 0) max += level * 2;
			if (max > 1299) max = 1299;//obecnie max to 1210
			return max;
		}
		
		public function maxMana():Number
		{
			var max:Number = 100;
			if (findPerk(PerkLib.ManaAffinityI) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityII) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityIII) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityIV) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityV) >= 0) max += 35;
			if (findPerk(PerkLib.ManaAffinityVI) >= 0) max += 35;
			if (findPerk(PerkLib.MindOverBodyI) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyII) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyIII) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyIV) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyV) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.MindOverBodyVI) >= 0) max += Math.round(inte*2);
			if (findPerk(PerkLib.ArcanePoolI) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolII) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolIII) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolIV) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolV) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.ArcanePoolVI) >= 0) {
				max += Math.round(inte);
				max += Math.round(wis);
			}
			if (findPerk(PerkLib.BasicSpirituality) >= 0) max += 45;
			if (findPerk(PerkLib.HalfStepToImprovedSpirituality) >= 0) max += 75;
			if (findPerk(PerkLib.ImprovedSpirituality) >= 0) max += 120;
			if (findPerk(PerkLib.HalfStepToAdvancedSpirituality) >= 0) max += 180;
			if (findPerk(PerkLib.AdvancedSpirituality) >= 0) max += 300;
			if (findPerk(PerkLib.HalfStepToSuperiorSpirituality) >= 0) max += 480;
			if (findPerk(PerkLib.SuperiorSpirituality) >= 0) max += 750;
			if (findPerk(PerkLib.HalfStepToPeerlessSpirituality) >= 0) max += 1050;
			if (findPerk(PerkLib.PeerlessSpirituality) >= 0) max += 1500;
			if (findPerk(PerkLib.Archmage) >= 0 && inte >= 75) max += 45;
			if (findPerk(PerkLib.Channeling) >= 0 && inte >= 60) max += 30;
			if (findPerk(PerkLib.GrandArchmage) >= 0 && inte >= 100) max += 60;
			if (findPerk(PerkLib.GreyArchmage) >= 0 && inte >= 125) max += 150;
			if (findPerk(PerkLib.GreyMage) >= 0 && inte >= 125) max += 105;
			if (findPerk(PerkLib.Mage) >= 0 && inte >= 50) max += 30;
			if (findPerk(PerkLib.Spellpower) >= 0 && inte >= 50) max += 15;
			if (findPerk(PerkLib.JobSorcerer) >= 0) max += 15;
			if (findPerk(PerkLib.ArcaneRegenerationMinor) >= 0 && inte >= 50) {
				var multimax:Number = 1;
				multimax += 0.1;
				if (findPerk(PerkLib.ArcaneRegenerationMajor) >= 0 && inte >= 75) multimax += 0.2;
				if (findPerk(PerkLib.ArcaneRegenerationEpic) >= 0 && inte >= 100) multimax += 0.3;
				if (findPerk(PerkLib.ArcaneRegenerationLegendary) >= 0 && inte >= 125) multimax += 0.4;
				max *= multimax;
			}
			max += level * 10;
			if (findPerk(PerkLib.UnlockMind) >= 0) max += level * 10;
			if (findPerk(PerkLib.AscensionUnlockedPotential) >= 0) max += level * 12;
			if (max > 59999) max = 59999;
			return max;
		}
		
		public function maxVenom():Number
		{
			var maxven:Number = 0;
			if (game.player.faceType == FACE_SNAKE_FANGS) maxven += 100;
			if (game.player.faceType == FACE_SPIDER_FANGS) maxven += 100;
			if (game.player.tailType == TAIL_TYPE_BEE_ABDOMEN) maxven += 150;
			if (game.player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) maxven += 150;
			if (game.player.tailType == TAIL_TYPE_SCORPION) maxven += 150;
			if (game.player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL) maxven += 200;
			if (findPerk(PerkLib.JobSoulCultivator) >= 0) {
				var multimaxven:Number = 1;
				if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) multimaxven += 0.1;
				if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) multimaxven += 0.15;
				maxven *= multimaxven;
			}
			return maxven;
		}
		
		public function maxHunger():Number
		{
			var max:Number = 100
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) max += 10;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 3) max += 10;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 4) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 5) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 6) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 7) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 8) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 9) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 10) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 11) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 12) max += 20;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 13) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 14) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 15) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 16) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 17) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 18) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 19) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 20) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 21) max += 25;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 22) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 23) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 24) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 25) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 26) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 27) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 28) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 29) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 30) max += 30;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 31) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 32) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 33) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 34) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 35) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 36) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 37) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 38) max += 35;
			if (flags[kFLAGS.SOUL_CULTIVATION] >= 39) max += 35;
			if (game.player.dragonScore() >= 20) max += 50;
			if (game.player.dragonScore() >= 28) max += 50;
			if (findPerk(PerkLib.EzekielBlessing) >= 0) max += 50;
			// (findPerk(PerkLib.) >= 0 && game.player.humanScore() < 5) max += 100;
			// jak bedzie mieć chimeryczna nature to kolejny boost to max hunger moze...150 lub nawet 200 ^^
			// (findPerk(PerkLib.IronStomach) >= 0) max += level;
			if (findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0) max += 20;
			if (findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0) max += 30;
			if (max > 1409) max = 1409;//obecnie max to 1360
			return max;
		}

	public function hairOrFur():String
	{
		return Appearance.hairOrFur(this);
	}

	public function hairDescript():String
	{
		return Appearance.hairDescription(this);
	}

	public function beardDescript():String
	{
		return Appearance.beardDescription(this);
	}

	public function hipDescript():String
	{
		return Appearance.hipDescription(this);
	}

	public function assDescript():String
	{
		return buttDescript();
	}

	public function buttDescript():String
	{
		return Appearance.buttDescription(this);
	}

	public function tongueDescript():String
	{
		return Appearance.tongueDescription(this);
	}

	public function hornDescript():String
	{
		return Appearance.DEFAULT_HORNS_NAMES[hornType] + " horns";
	}

	public function tailDescript():String
	{
		return Appearance.tailDescript(this);
	}

	public function oneTailDescript():String
	{
		return Appearance.oneTailDescript(this);
	}

	public function wingsDescript():String
	{
		return Appearance.wingsDescript(this);
	}

	public function eyesDescript():String
	{
		return Appearance.eyesDescript(this);
	}

	}

}
