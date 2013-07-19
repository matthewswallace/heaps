import h3d.scene.*;

class Test {
	
	var engine : h3d.Engine;
	var time : Float;
	var scene : Scene;
	var obj1 : Mesh;
	var obj2 : Mesh;
	
	function new() {
		time = 0;
		engine = new h3d.Engine();
		engine.debug = true;
		engine.backgroundColor = 0x202020;
		engine.onReady = start;
		engine.init();
	}
	
	function start() {
		hxd.System.setLoop(update);
		
		var prim = new h3d.prim.Cube();
		prim.translate( -0.5, -0.5, -0.5);
		prim.addUVs();
		prim.addNormals();
		
		var bmp : hxd.BitmapData = null;
		#if flash
		var tbmp = new flash.display.BitmapData(256, 256);
		tbmp.perlinNoise(64, 64, 3, 0, true, true, 7);
		bmp = hxd.BitmapData.fromNative(tbmp);
		#end
		var tex = h3d.mat.Texture.fromBitmap(bmp);
		var mat = new h3d.mat.MeshMaterial(tex);
		bmp.dispose();
		
		scene = new Scene();
		obj1 = new Mesh(prim, mat, scene);
		obj2 = new Mesh(prim, mat, scene);
		
		mat.lightSystem = {
			ambient : new h3d.Vector(0, 0, 0),
			dirs : [{ dir : new h3d.Vector(-0.3,-0.5,-1), color : new h3d.Vector(1,1,1) }],
			points : [{ pos : new h3d.Vector(1.5,0,0), color : new h3d.Vector(3,0,0), att : new h3d.Vector(0,0,1) }],
		};
	}
	
	function update() {
		var dist = 5;
		time += 0.01;
		scene.camera.pos.set(Math.cos(time) * dist, Math.sin(time) * dist, 3);
		obj2.setRotateAxis(-0.5, 2, Math.cos(time), time + Math.PI / 2);
		engine.render(scene);
	}
	
	static function main() {
		#if flash
		haxe.Log.setColor(0xFF0000);
		#end
		new Test();
	}
	
}