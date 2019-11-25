source('~/GitHub/migration/functions.R')
ggp = worldbasemap()

migrationmap(ggp = ggp, rawpath1 = "ebd_oripra_relApr-2019.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 74,minlat = -35,maxlong = 170, maxlat = 50)

PROJ = "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 
#PROJ = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs" 

min = project(cbind(74,-35), proj = PROJ)
max = project(cbind(170,50), proj = PROJ)

min = project(cbind(-15,-3), proj = PROJ)
max = project(cbind(142,55), proj = PROJ)

#World
min = project(cbind(-180,-70), proj = PROJ)
max = project(cbind(180,70), proj = PROJ)

#Old World
min = project(cbind(-15,-45), proj = PROJ)
max = project(cbind(180,75), proj = PROJ)

#India
min = project(cbind(67.5,5), proj = PROJ)
max = project(cbind(100,37), proj = PROJ)

ggp +
  coord_cartesian(xlim = c(min[1],max[1]), ylim = c(min[2],max[2]))

############################################### Africa #########################################


#gc() # Wilson's Storm-Petrel world
migrationmap(ggp = ggp, rawpath1 = "ebd_wispet_relJun-2019.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = -180,minlat = -70,maxlong = 180, maxlat = 70)

#gc() # Flesh-footed Shearwater
migrationmap(ggp = ggp, rawpath1 = "ebd_flfshe_relJun-2019.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = -180,minlat = -70,maxlong = 180, maxlat = 70)

#gc() # Common Sandpiper Old World
migrationmap(ggp = ggp, rawpath1 = "ebd_comsan_relJun-2019.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = -15,minlat = -45,maxlong = 180, maxlat = 75)

#gc() # Common Sandpiper India
migrationmap(ggp = ggp, rawpath1 = "ebd_comsan_relJun-2019.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 67.5,minlat = 5,maxlong = 100, maxlat = 37)

gc() # GSE - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "Greater spotted eagle.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = -15,minlat = -3,maxlong = 142, maxlat = 55)

gc() # LSE - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "Lesser spotted eagle.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = -15,minlat = -3,maxlong = 142, maxlat = 55)

gc() # ISE - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "Indian spotted eagle.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = -15,minlat = -3,maxlong = 142, maxlat = 55)

gc() # ISE - India
migrationmap(ggp = ggp, rawpath1 = "Indian spotted eagle.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 67.5,minlat = 5,maxlong = 100, maxlat = 37)

gc() # Hybrid - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "Hybrid.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = -15,minlat = -3,maxlong = 142, maxlat = 55)

gc() # Lesser Kestrel - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_leskes1_relJan-2019.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Short-eared Owl - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_sheowl_relJan-2019.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Chestnut-headed Bee-Eater - India
migrationmap(ggp = ggp, rawpath1 = "ebd_chbeat1_relJan-2019.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Pied Thrush - India
migrationmap(ggp = ggp, rawpath1 = "ebd_piethr1_relJan-2019.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

#gc() # Common Pochard vs. Northern Shoveler - India
migrationmap(ggp = ggp, rawpath1 = "ebd_compoc_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 60,minlat = 5,maxlong = 130, maxlat = 50,n = 2,
             rawpath2 = "ebd_norsho_relAug-2018.txt")

#gc() # Common Pochard vs. Northern Pintail - India
migrationmap(ggp = ggp, rawpath1 = "ebd_compoc_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 60,minlat = 5,maxlong = 130, maxlat = 50,n = 2,
             rawpath2 = "ebd_norpin_relAug-2018.txt")

#gc() # Bar-headed goose - India
migrationmap(ggp = ggp, rawpath1 = "ebd_bahgoo_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 60,minlat = 5,maxlong = 130, maxlat = 50)

#gc() # Demoiselle crane - India
migrationmap(ggp = ggp, rawpath1 = "ebd_demcra1_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 60,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Blue-cheeked bee-eater - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_bcbeat1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Spotted Flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_spofly1_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 60,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Rufous-tailed Scrub Robin - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_rtsrob1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)



gc() # Black-tailed Godwit - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_bktgod_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Little stint - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_litsti_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Tree pipit - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_trepip_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Western marsh harrier - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_wemhar1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Bar-tailed godwit - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_batgod_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Common pochard - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_compoc_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Ferruginous duck - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_ferduc_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Barn swallow - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_barswa_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Western yellow wagtail - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_eaywag1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)

gc() # Greater spotted eagle - inc. Africa
migrationmap(ggp = ggp, rawpath1 = "ebd_grseag1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10)


############################################### Eurasia #########################################


#gc() # Greenish warbler vs. Green warbler - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_grewar3_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlat = 5,n = 2,rawpath2 = "ebd_grnwar1_relAug-2018.txt")

gc() # Black-headed bunting vs. Red-headed bunting - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_blhbun1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlat = 5,n = 2,rawpath2 = "ebd_rehbun1_relAug-2018.txt")

gc() # Red-breasted flycatcher vs. Taiga flycatcher - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_rebfly_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlat = 5,n = 2,rawpath2 = "ebd_taifly1_relAug-2018.txt")

gc() # Blyth's pipit vs. Richard's pipit - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_blypip1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlat = 5,n = 2,rawpath2 = "ebd_ricpip1_relAug-2018.txt")

gc() # Booted warbler vs. Sykes's warbler - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_boowar1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlat = 5,n = 2,rawpath2 = "ebd_sykwar2_relAug-2018.txt")

gc() # Brown shrike vs. Isabelline shrike - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_brnshr_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlat = 5,n = 2,rawpath2 = "ebd_isashr1_relAug-2018.txt")

gc() # Lesser whitethroat vs. Hume's whitethroat - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_leswhi1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlat = 5,n = 2,rawpath2 = "ebd_humwhi1_relAug-2018.txt")

gc() # Common rosefinch - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_comros_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10, minlat = 5)

gc() # Black redstart - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_blared1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10, minlat = 5)

gc() # Bluethroat - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_blueth_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10, minlat = 5)

gc() # Blyth's reed warbler - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_blrwar1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,minlat = 5)

gc() # Rosy starling - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_rossta2_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,minlat = 5)

gc() # Yellow-browed warbler - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_yebwar3_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,minlat = 5)

gc() # Demoiselle crane - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_demcra1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,minlat = 5)

gc() # Grey-necked bunting - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_gyhbun1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,minlat = 5)

gc() # Asian brown flycatcher - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_asbfly_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,minlat = 5)

gc() # Baillon's crake - Eurasia
migrationmap(ggp = ggp, rawpath1 = "ebd_baicra1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10, minlat = 5)



################################## India ##################################################

gc() # Indian skimmer vs. Black-bellied tern - India
migrationmap(ggp = ggp, rawpath1 = "ebd_indski1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50,n = 2,rawpath2 = "ebd_blbter1_relAug-2018.txt")

gc() # Grey-headed canary-flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_gyhcaf1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Rusty-tailed flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_rutfly6_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Tytler's leaf warbler - India
migrationmap(ggp = ggp, rawpath1 = "ebd_tylwar1_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Kashmir flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_kasfly1_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Black-headed cuckooshrike - India
migrationmap(ggp = ggp, rawpath1 = "ebd_bkhcus1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Brook's leaf warbler - India
migrationmap(ggp = ggp, rawpath1 = "ebd_brlwar1_relAug-2018.txt",res = 144,range = 35,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Lesser flamingo - India
migrationmap(ggp = ggp, rawpath1 = "ebd_lesfla1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Greater flamingo - India
migrationmap(ggp = ggp, rawpath1 = "ebd_grefla3_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Brown-breasted flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_brbfly2_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Verditer flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_verfly4_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Tickell's leaf warbler - India
migrationmap(ggp = ggp, rawpath1 = "ebd_tilwar1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Oriental dwarf kingfisher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_bkbkin1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Indian Golden Oriole - India
migrationmap(ggp = ggp, rawpath1 = "ebd_ingori1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Blue-capped rock-thrush - India
migrationmap(ggp = ggp, rawpath1 = "ebd_bcrthr1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Blue-throated flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_butfly1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Indian paradise-flycatcher - India
migrationmap(ggp = ggp, rawpath1 = "ebd_aspfly1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Indian blue robin - India
migrationmap(ggp = ggp, rawpath1 = "ebd_inbrob1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Western-crowned warbler - India
migrationmap(ggp = ggp, rawpath1 = "ebd_weclew1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Indian pitta - India
migrationmap(ggp = ggp, rawpath1 = "ebd_indpit1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)

gc() # Large-billed leaf warbler - India
migrationmap(ggp = ggp, rawpath1 = "ebd_lblwar1_relAug-2018.txt",res = 144,range = 30,step = 2,fps = 10,
             minlong = 70,minlat = 5,maxlong = 130, maxlat = 50)