import React from "react";
import Svg, { Path, Rect } from "react-native-svg";
const ArrowBack = () => (
  <Svg width={35} height={35} viewBox="0 0 35 35" fill="none">
    <Rect
      width={35}
      height={35}
      rx={10}
      transform="matrix(-1 0 0 1 35 0)"
      fill="#F1F1F1"
    />
    <Path
      d="M20.875 10.75L14.125 17.5L20.875 24.25"
      stroke="white"
      strokeWidth={2.025}
      strokeLinecap="round"
      strokeLinejoin="round"
    />
    <Path
      d="M20.875 10.75L14.125 17.5L20.875 24.25"
      stroke="#0C1534"
      strokeWidth={2.025}
      strokeLinecap="round"
      strokeLinejoin="round"
    />
  </Svg>
);

export default ArrowBack;
