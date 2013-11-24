//NEVER USE THIS IT SUX	-PETETHEGOAT

var/global/list/cached_icons = list()

/obj/item/weapon/paint
	name = "paint can"
	desc = "Used to recolor floors and walls. Can not be removed by the janitor."
	icon = 'icons/obj/items.dmi'
	icon_state = "paint_neutral"
	item_color = "FFFFFF"
	item_state = "paintcan"
	w_class = 3.0
	var/paintleft = 10

/obj/item/weapon/paint/red
	gender= PLURAL
	name = "red paint"
	item_color = "C73232" //"FF0000"
	icon_state = "paint_red"

/obj/item/weapon/paint/green
	gender= PLURAL
	name = "green paint"
	item_color = "2A9C3B" //"00FF00"
	icon_state = "paint_green"

/obj/item/weapon/paint/blue
	gender= PLURAL
	name = "blue paint"
	item_color = "5998FF" //"0000FF"
	icon_state = "paint_blue"

/obj/item/weapon/paint/yellow
	gender= PLURAL
	name = "yellow paint"
	item_color = "CFB52B" //"FFFF00"
	icon_state = "paint_yellow"

/obj/item/weapon/paint/violet
	gender= PLURAL
	name = "violet paint"
	item_color = "AE4CCD" //"FF00FF"
	icon_state = "paint_violet"

/obj/item/weapon/paint/black
	gender= PLURAL
	name = "black paint"
	item_color = "333333"
	icon_state = "paint_black"

/obj/item/weapon/paint/white
	gender= PLURAL
	name = "white paint"
	item_color = "FFFFFF"
	icon_state = "paint_white"


/obj/item/weapon/paint/anycolor
	gender= PLURAL
	name = "any color"
	icon_state = "paint_neutral"

	attack_self(mob/user as mob)
		var/t1 = input(user, "Please select a color:", "Locking Computer", null) in list( "red", "blue", "green", "yellow", "violet", "black", "white")
		if ((user.get_active_hand() != src || user.stat || user.restrained()))
			return
		switch(t1)
			if("red")
				item_color = "C73232"
			if("blue")
				item_color = "5998FF"
			if("green")
				item_color = "2A9C3B"
			if("yellow")
				item_color = "CFB52B"
			if("violet")
				item_color = "AE4CCD"
			if("white")
				item_color = "FFFFFF"
			if("black")
				item_color = "333333"
		icon_state = "paint_[t1]"
		add_fingerprint(user)
		return


/obj/item/weapon/paint/afterattack(turf/target, mob/user as mob, proximity)
	if(!proximity) return
	if(paintleft <= 0)
		icon_state = "paint_empty"
		return
	if(!istype(target) || istype(target, /turf/space))
		return
	var/ind = "[initial(target.icon)][item_color]"
	if(!cached_icons[ind])
		var/icon/overlay = new/icon(initial(target.icon))
		overlay.Blend("#[item_color]",ICON_MULTIPLY)
		overlay.SetIntensity(1.4)
		target.icon = overlay
		cached_icons[ind] = target.icon
		paintleft--
	else
		target.icon = cached_icons[ind]
		paintleft--
	return

/obj/item/weapon/paint/paint_remover
	gender =  PLURAL
	name = "paint remover"
	icon_state = "paint_neutral"

	afterattack(turf/target, mob/user as mob,proximity)
		if(!proximity) return
		if(istype(target) && target.icon != initial(target.icon))
			target.icon = initial(target.icon)
		return
