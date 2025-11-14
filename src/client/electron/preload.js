const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("electronAPI", {
  isElectron: true,
  send: (channel, data) => ipcRenderer.send(channel, data),
});
