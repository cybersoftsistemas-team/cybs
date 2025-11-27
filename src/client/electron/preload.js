const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("electronAPI", {
  on: (channel, callback) => {
    ipcRenderer.on(channel, (event, data) => callback(data));
  },
  openWindow: (options) => ipcRenderer.send("open-window", options),
  send: (channel, data) => {
    ipcRenderer.send(channel, data);
  },
});

contextBridge.exposeInMainWorld("Application", {
  loadConfig: () => ipcRenderer.invoke("application-load-config"),
  messageBox: (options) => ipcRenderer.invoke("message-box", options),
  reload: (url) => ipcRenderer.send("application-reload", url),
  saveConfig: (config) => ipcRenderer.send("application-save-config", config),
});

contextBridge.exposeInMainWorld("electronEnv", {
  isElectron: true,
});
