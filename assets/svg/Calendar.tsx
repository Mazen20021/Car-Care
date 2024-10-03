import React from "react";
import Svg, { Path, Rect } from "react-native-svg";

function Calendar({ fill }) {
  return (
    <Svg width="20" height="21" viewBox="0 0 20 21" fill="none">
      <Rect
        width="19.9979"
        height="20"
        rx="5.69638"
        transform="matrix(-4.37114e-08 -1 -1 4.37114e-08 20 20.8538)"
        fill={fill}
      />
      <Rect
        width="19.9979"
        height="20"
        rx="5.69638"
        transform="matrix(-4.37114e-08 -1 -1 4.37114e-08 20 20.8538)"
        fill="#0C1534"
      />
      <Path
        d="M12.7778 10.2994H7.22222V11.4105H12.7778V10.2994ZM13.8889 6.41049H13.3333V5.29938H12.2222V6.41049H7.77778V5.29938H6.66667V6.41049H6.11111C5.49444 6.41049 5.00556 6.91049 5.00556 7.5216L5 15.2994C5 15.9105 5.49444 16.4105 6.11111 16.4105H13.8889C14.5 16.4105 15 15.9105 15 15.2994V7.5216C15 6.91049 14.5 6.41049 13.8889 6.41049ZM13.8889 15.2994H6.11111V9.18827H13.8889V15.2994ZM11.1111 12.5216H7.22222V13.6327H11.1111V12.5216Z"
        fill="white"
      />
    </Svg>
  );
}

export default Calendar;
