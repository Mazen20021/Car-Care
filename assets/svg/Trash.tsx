import React from "react";
import Svg, { Path } from "react-native-svg";
function Trash({ fill }) {
  return (
    <Svg width="18" height="17" viewBox="0 0 18 17" fill="none">
      <Path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M6.45001 13.4934H8.15V7.01721H6.45001V13.4934ZM9.85 13.4934H11.55V7.01721H9.85V13.4934ZM4.75 15.1124H13.25V5.39816H4.75V15.1124ZM6.45001 3.77911H11.55V2.16006H6.45001V3.77911ZM13.25 3.77911V0.541016H4.75V3.77911H0.5V5.39816H3.05V16.7315H14.95V5.39816H17.5V3.77911H13.25Z"
        fill="#C00808"
      />
    </Svg>
  );
}

export default Trash;
