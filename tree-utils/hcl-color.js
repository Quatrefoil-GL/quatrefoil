import { hcl } from "d3-color";

export let hcl_to_hex = (h, c, l) => {
  let color = hcl(h, c, l);
  return color.formatHex();
};
