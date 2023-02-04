import React from "react";
import ReactDOM from "react-dom/client";
import { App } from "./App";
import { grey } from "@mui/material/colors";
import { createTheme, ThemeProvider } from "@mui/material/styles";
import "./index.css";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);
root.render(
  <React.StrictMode>
    <ThemeProvider
      theme={createTheme({
        palette: {
          primary: {
            main: grey[900],
          },
        },
        typography: {
          button: {
            textTransform: "none",
          },
        },
      })}
    >
      <App />
    </ThemeProvider>
  </React.StrictMode>
);
