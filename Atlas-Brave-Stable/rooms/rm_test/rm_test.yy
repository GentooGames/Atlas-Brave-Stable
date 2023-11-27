{
  "resourceType": "GMRoom",
  "resourceVersion": "1.0",
  "name": "rm_test",
  "isDnd": false,
  "volume": 1.0,
  "parentRoom": null,
  "views": [
    {"inherit":false,"visible":true,"xview":0,"yview":0,"wview":512,"hview":288,"xport":0,"yport":0,"wport":1536,"hport":864,"hborder":120,"vborder":120,"hspeed":-1,"vspeed":-1,"objectId":{"name":"obj_hero","path":"objects/obj_hero/obj_hero.yy",},},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":1366,"hview":768,"xport":0,"yport":0,"wport":1366,"hport":768,"hborder":0,"vborder":0,"hspeed":-1,"vspeed":-1,"objectId":{"name":"objc_camera","path":"objects/objc_camera/objc_camera.yy",},},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":1366,"hview":768,"xport":0,"yport":0,"wport":1366,"hport":768,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":1366,"hview":768,"xport":0,"yport":0,"wport":1366,"hport":768,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":1366,"hview":768,"xport":0,"yport":0,"wport":1366,"hport":768,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":1366,"hview":768,"xport":0,"yport":0,"wport":1366,"hport":768,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":1366,"hview":768,"xport":0,"yport":0,"wport":1366,"hport":768,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
    {"inherit":false,"visible":false,"xview":0,"yview":0,"wview":1366,"hview":768,"xport":0,"yport":0,"wport":1366,"hport":768,"hborder":32,"vborder":32,"hspeed":-1,"vspeed":-1,"objectId":null,},
  ],
  "layers": [
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Collisions","instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_58B01DB0","properties":[],"isDnd":false,"objectId":{"name":"obj_solid_precise","path":"objects/obj_solid_precise/obj_solid_precise.yy",},"inheritCode":false,"hasCreationCode":false,"colour":4294967295,"rotation":25.963211,"scaleX":18.0,"scaleY":1.0,"imageIndex":0,"imageSpeed":1.0,"inheritedItemId":null,"frozen":false,"ignore":false,"inheritItemSettings":false,"x":128.0,"y":200.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_6E7834B5","properties":[],"isDnd":false,"objectId":{"name":"obj_solid","path":"objects/obj_solid/obj_solid.yy",},"inheritCode":false,"hasCreationCode":false,"colour":4294967295,"rotation":0.0,"scaleX":4.0,"scaleY":3.0,"imageIndex":0,"imageSpeed":1.0,"inheritedItemId":null,"frozen":false,"ignore":false,"inheritItemSettings":false,"x":408.0,"y":216.0,},
      ],"visible":false,"depth":0,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"gridX":8,"gridY":8,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Entities","instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_621695D9","properties":[],"isDnd":false,"objectId":{"name":"obj_chest_item","path":"objects/obj_chest_item/obj_chest_item.yy",},"inheritCode":false,"hasCreationCode":false,"colour":4294967295,"rotation":0.0,"scaleX":-1.0,"scaleY":1.0,"imageIndex":0,"imageSpeed":1.0,"inheritedItemId":null,"frozen":false,"ignore":false,"inheritItemSettings":false,"x":376.0,"y":152.0,},
      ],"visible":true,"depth":100,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"gridX":8,"gridY":8,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"Spawns","instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_619D91C5","properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"types","path":"objects/obj_spawn_point/obj_spawn_point.yy",},"objectId":{"name":"obj_spawn_point","path":"objects/obj_spawn_point/obj_spawn_point.yy",},"value":"obj_hero",},
          ],"isDnd":false,"objectId":{"name":"obj_spawn_point","path":"objects/obj_spawn_point/obj_spawn_point.yy",},"inheritCode":false,"hasCreationCode":false,"colour":4294967295,"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"imageIndex":0,"imageSpeed":1.0,"inheritedItemId":null,"frozen":false,"ignore":false,"inheritItemSettings":false,"x":280.0,"y":208.0,},
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_497AF446","properties":[
            {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","propertyId":{"name":"types","path":"objects/obj_spawn_point/obj_spawn_point.yy",},"objectId":{"name":"obj_spawn_point","path":"objects/obj_spawn_point/obj_spawn_point.yy",},"value":"obj_enemy, obj_boss",},
          ],"isDnd":false,"objectId":{"name":"obj_spawn_point","path":"objects/obj_spawn_point/obj_spawn_point.yy",},"inheritCode":false,"hasCreationCode":false,"colour":4294967295,"rotation":0.0,"scaleX":1.0,"scaleY":1.0,"imageIndex":0,"imageSpeed":1.0,"inheritedItemId":null,"frozen":false,"ignore":true,"inheritItemSettings":false,"x":352.0,"y":208.0,},
      ],"visible":true,"depth":200,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"gridX":8,"gridY":8,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRInstanceLayer","resourceVersion":"1.0","name":"MP_Grid","instances":[
        {"resourceType":"GMRInstance","resourceVersion":"1.0","name":"inst_3B42F08B","properties":[],"isDnd":false,"objectId":{"name":"IB_Object_Navmesh","path":"objects/IB_Object_Navmesh/IB_Object_Navmesh.yy",},"inheritCode":false,"hasCreationCode":false,"colour":4294967295,"rotation":0.0,"scaleX":64.0,"scaleY":40.0,"imageIndex":0,"imageSpeed":1.0,"inheritedItemId":null,"frozen":false,"ignore":false,"inheritItemSettings":false,"x":72.0,"y":40.0,},
      ],"visible":true,"depth":300,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"gridX":8,"gridY":8,"layers":[],"hierarchyFrozen":false,"effectEnabled":true,"effectType":null,"properties":[],},
    {"resourceType":"GMRBackgroundLayer","resourceVersion":"1.0","name":"Background","spriteId":{"name":"bg_Tuvale_Forest_combat_01","path":"sprites/bg_Tuvale_Forest_combat_01/bg_Tuvale_Forest_combat_01.yy",},"colour":4294967295,"x":0,"y":0,"htiled":false,"vtiled":false,"hspeed":0.0,"vspeed":0.0,"stretch":false,"animationFPS":30.0,"animationSpeedType":0,"userdefinedAnimFPS":false,"visible":true,"depth":400,"userdefinedDepth":false,"inheritLayerDepth":false,"inheritLayerSettings":false,"gridX":32,"gridY":32,"layers":[],"hierarchyFrozen":true,"effectEnabled":true,"effectType":null,"properties":[],},
  ],
  "inheritLayers": false,
  "creationCodeFile": "",
  "inheritCode": false,
  "instanceCreationOrder": [
    {"name":"inst_58B01DB0","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_6E7834B5","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_619D91C5","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_497AF446","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_3B42F08B","path":"rooms/rm_test/rm_test.yy",},
    {"name":"inst_621695D9","path":"rooms/rm_test/rm_test.yy",},
  ],
  "inheritCreationOrder": false,
  "sequenceId": null,
  "roomSettings": {
    "inheritRoomSettings": false,
    "Width": 640,
    "Height": 400,
    "persistent": false,
  },
  "viewSettings": {
    "inheritViewSettings": false,
    "enableViews": true,
    "clearViewBackground": false,
    "clearDisplayBuffer": true,
  },
  "physicsSettings": {
    "inheritPhysicsSettings": false,
    "PhysicsWorld": false,
    "PhysicsWorldGravityX": 0.0,
    "PhysicsWorldGravityY": 10.0,
    "PhysicsWorldPixToMetres": 0.1,
  },
  "parent": {
    "name": "world",
    "path": "folders/world.yy",
  },
}