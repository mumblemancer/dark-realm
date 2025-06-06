/mob/living/simple_animal/cockroach
	name = "cockroach"
	desc = ""
	icon_state = "cockroach"
	icon_dead = "cockroach"
	health = 1
	maxHealth = 1
	turns_per_move = 5
	loot = list(/obj/effect/decal/cleanable/insectguts)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 270
	maxbodytemp = INFINITY
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BUG
	response_disarm_continuous = "shoos"
	response_disarm_simple = "shoo"
	response_harm_continuous = "splats"
	response_harm_simple = "splat"
	speak_emote = list("chitters")
	density = FALSE
	ventcrawler = VENTCRAWLER_ALWAYS
	gold_core_spawnable = FRIENDLY_SPAWN
	verb_say = "chitters"
	verb_ask = "chitters inquisitively"
	verb_exclaim = "chitters loudly"
	verb_yell = "chitters loudly"
	var/squish_chance = 50
	del_on_death = 1

/mob/living/simple_animal/cockroach/death(gibbed)
	..()

/mob/living/simple_animal/cockroach/Crossed(atom/movable/AM)
	if(ismob(AM))
		if(isliving(AM))
			var/mob/living/A = AM
			if(A.mob_size > MOB_SIZE_SMALL && !(A.movement_type & FLYING))
				if(prob(squish_chance))
					if(ishuman(A))
						var/mob/living/carbon/human/H = A
						if(HAS_TRAIT(H, TRAIT_PACIFISM))
							H.visible_message(span_notice("[src] avoids getting crushed."), span_warning("I avoid crushing [src]!"))
							return
					A.visible_message(span_notice("[A] crushes [src]."), span_notice("I crushed [src]."))
					adjustBruteLoss(1) //kills a normal cockroach
				else
					visible_message(span_notice("[src] avoids getting crushed."))
	else
		if(isstructure(AM))
			if(prob(squish_chance))
				AM.visible_message(span_notice("[src] was crushed under [AM]."))
				adjustBruteLoss(1)
			else
				visible_message(span_notice("[src] avoids getting crushed."))

/mob/living/simple_animal/cockroach/ex_act() //Explosions are a terrible way to handle a cockroach.
	return
