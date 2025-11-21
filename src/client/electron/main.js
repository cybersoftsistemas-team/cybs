import { app, BrowserWindow, dialog, ipcMain } from "electron";
import { dirname, join } from "path";
import { fileURLToPath } from "url";
import fs from "fs";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

let configDir;
let win;

if (process.platform === "win32") {
  const baseProgramData = process.env.ProgramData || "C:\\ProgramData";
  configDir = join(baseProgramData, ".cybersoft", "config");
} else if (process.platform === "linux") {
  configDir = "/var/opt/cybersoft/config";
} else if (process.platform === "darwin") {
  configDir = "/Library/Application Support/Cybersoft/config";
}

const configPath = join(configDir, "config.json");

if (!fs.existsSync(configDir)) {
  fs.mkdirSync(configDir, { recursive: true });
}

async function loadConfig() {
  try {
    if (fs.existsSync(configPath)) {
      return JSON.parse(fs.readFileSync(configPath, "utf8"));
    }
  } catch (err) {
    win.hide();
    await dialog.showMessageBox(win, {
      modal: true,
      ...{
        type: "error",
        title: "Cybersoft Sistemas - Erro config",
        message: "Erro ao ler config: " + err.message,
      },
    });
    app.quit();
  }
  return { serverUrl: "http://localhost:8077" }; // valor padrão
};

function createWindow() {
  win = new BrowserWindow({
    width: 467,
    height: 387,
    frame: true,
    autoHideMenuBar: true,
    minimizable: true,
    maximizable: false,
    resizable: false,
    icon: __dirname + "/files/icons/cbs.ico",
    webPreferences: {
      preload: join(__dirname, "preload.js"),
      nodeIntegration: false,
      contextIsolation: true,
    },
  });

  // win.webContents.session.clearCache().then(() => {
  //   win.webContents.reloadIgnoringCache();
  // });

  // win.webContents.openDevTools({ mode: "detach" });

  win.setTitle("Cybersoft Sistemas");

  ipcMain.handle("message-box", async (event, options) => {
    return await dialog.showMessageBox(win, {
      modal: true, 
      ...options,
    });
  });

  ipcMain.on("after-login", (event, obj) => {
    if (!win) return;
    win.setResizable(true);
    win.setMaximizable(true);
    win.setSize(obj.w, obj.h);
    win.center();
  });

  ipcMain.on("application-reload", (event, url) => {
    if (!win) return;
    try {
      win.loadURL(url);
    } catch (err) {
      console.error("Erro ao recarregar URL:", err);
      win.loadFile(join(__dirname, "err_conn_refused.html"));
    }
  });

  ipcMain.on("application-save-config", (event, config) => {
    try {
      fs.writeFileSync(configPath, JSON.stringify(config, null, 2));
    } catch (err) {
      dialog.showMessageBoxSync(win, {
        type: "error",
        message: "Erro ao salvar config: " + err.message
      });
    }
  });

  win.webContents.on("did-fail-load", (event, code, desc) => {
    win.loadFile(join(__dirname, "err_conn_refused.html"));
  });
}

app
  .whenReady()
  .then(async () => {
    createWindow();

    const cfg = await loadConfig();
    win.loadURL(cfg.serverUrl);
    win.setMenu(null);
    win.center();
  })
  .catch((err) => console.error("Erro ao iniciar app:", err));

app.on("activate", () => {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});