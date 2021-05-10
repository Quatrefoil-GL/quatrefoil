
import * as THREE from 'three';
// import { SceneUtils } from "three/examples/jsm/utils/SceneUtils";

// https://threejs.org/docs/#api/en/geometries/TubeGeometry

export let makeCurve = (f) => {

  class CustomSinCurve extends THREE.Curve {

    constructor( scale = 1 ) {
      super();
      this.scale = scale;
    }

    getPoint( t, optionalTarget = new THREE.Vector3() ) {

      let t2 = isNaN(t) ? 1 : t;

      let v = f(t2);

      let tx = v.get(0);
      let ty = v.get(1);
      let tz = v.get(2);

      // console.log("point:", v, tx, ty, tz);

      return optionalTarget.set( tx, ty, tz ).multiplyScalar( this.scale );
    }
  }

  return new CustomSinCurve();
}
