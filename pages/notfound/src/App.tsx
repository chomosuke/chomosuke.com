import karasu from "./karasu.png";
import Levenshtein from "levenshtein";
import { Button } from "@mui/material";
import { useViewport } from "./viewport";

export function App() {
  const subdomain = window.location.hostname;

  const validSubdomains = [
    "lumpime.chomosuke.com",
    "catballchard.chomosuke.com",
    "chomosuke.com",
  ];

  validSubdomains.sort(
    (a, b) =>
      new Levenshtein(subdomain, a).distance -
      new Levenshtein(subdomain, b).distance
  );

  const viewport = useViewport();

  const karasuMargin = viewport.width > 512 ? 64 : viewport.width / 8;

  return (
    <div
      style={{
        background: "#bdd6ae",
        height: "100vh",
        width: "100vw",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      <div
        style={{
          width: viewport.width < 480 ? 240 : "50%",
          height: "fit-content",
          paddingBottom: 100,
        }}
      >
        <h1>404</h1>
        <h2>Subdomain not found!</h2>
        <p>
          The subdomain <code>{subdomain}</code> does not exist. Do you mean one
          of the following instead?
        </p>
        {validSubdomains.map((validSubdomain) => (
          <Button
            variant="outlined"
            href={`https://${validSubdomain}/`}
            fullWidth={true}
            sx={{ marginBottom: "16px" }}
          >
            {validSubdomain}
          </Button>
        ))}
      </div>
      <img
        src={karasu}
        alt="karasu"
        width="150"
        style={{ position: "absolute", bottom: karasuMargin, right: karasuMargin }}
      />
    </div>
  );
}
