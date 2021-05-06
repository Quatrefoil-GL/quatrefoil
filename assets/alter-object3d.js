// dirty patching to Object3D to make use of diff/patching
// https://github.com/mrdoob/three.js/blob/dev/src/core/Object3D.js

import * as THREE from 'three';

let getStr = function(x) {
  if (typeof x === 'string') {
    return x;
  } else {
    return x.toString();
  }
};

THREE.Object3D.prototype.addBy = function(k, v) {
  if (this.childMap == null) {
    this.childMap = {};
  }
  this.childMap[getStr(k)] = v;
  this.add(v);
};

THREE.Object3D.prototype.removeBy = function(k) {
  if (this.childMap == null) {
    console.warn('Calling removeBy without childMap');
  } else {
    let v = this.childMap[getStr(k)];
    delete this.childMap[getStr(k)];
    this.remove(v);
  }
};

THREE.Object3D.prototype.replaceBy = function(k, v) {
  if (this.childMap == null) {
    console.warn('Calling replaceBy without childMap');
  } else {
    let prevChild = this.childMap[getStr(k)];
    this.remove(prevChild);
    this.childMap[getStr(k)] = v;
    this.add(v);
  }
};

THREE.Object3D.prototype.reachBy = function(k) {
  if (this.childMap == null) {
    console.warn('Calling reachBy without childMap');
    return null;
  } else {
    return this.childMap[getStr(k)];
  }
};

export function inject_bang() {
  console.info("injecting addBy methods");
}
