import { useState, useEffect } from 'react';

function getViewport() {
  const { innerWidth: width, innerHeight: height } = window;
  return {
    width,
    height
  };
}

export function useViewport() {
  const [windowDimensions, setWindowDimensions] = useState(getViewport());

  useEffect(() => {
    function handleResize() {
      setWindowDimensions(getViewport());
    }

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  return windowDimensions;
}
