import React from "react";
import Svg, { Path } from "react-native-svg";
import { MainColors } from "@/styles";
function Eye() {
  return (
    <Svg width="15" height="13" viewBox="0 0 15 13" fill="none">
      <Path
        d="M5.8125 6.5C5.8125 5.56805 6.56805 4.8125 7.5 4.8125C8.43195 4.8125 9.1875 5.56805 9.1875 6.5C9.1875 7.43195 8.43195 8.1875 7.5 8.1875C6.56805 8.1875 5.8125 7.43195 5.8125 6.5Z"
        fill={MainColors.black}
      />
      <Path
        fill-rule="evenodd"
        clip-rule="evenodd"
        d="M0 6.5C0 7.72955 0.31872 8.14362 0.956167 8.97177C2.22897 10.6253 4.36358 12.5 7.5 12.5C10.6364 12.5 12.771 10.6253 14.0438 8.97177C14.6812 8.14362 15 7.72955 15 6.5C15 5.27045 14.6812 4.8564 14.0438 4.02825C12.771 2.37467 10.6364 0.5 7.5 0.5C4.36358 0.5 2.22897 2.37467 0.956167 4.02825C0.31872 4.8564 0 5.27045 0 6.5ZM7.5 3.6875C5.9467 3.6875 4.6875 4.9467 4.6875 6.5C4.6875 8.05332 5.9467 9.3125 7.5 9.3125C9.05332 9.3125 10.3125 8.05332 10.3125 6.5C10.3125 4.9467 9.05332 3.6875 7.5 3.6875Z"
        fill={MainColors.black}
      />
    </Svg>
  );
}

export default Eye;
