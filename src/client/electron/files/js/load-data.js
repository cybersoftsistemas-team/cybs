function loadData(sender, fileName) {
  if (AppEnv.isElectron()) {
    window.electronAPI.loadClientData(fileName).then((data) => {
      ajaxRequest(sender, "LoadClientData", [
        "file=" + fileName,
        "value=" + data,
      ]);
    });
  } else {
    const value = localStorage.getItem(fileName) || "";
    ajaxRequest(sender, "LoadClientData", [
      "file=" + fileName,
      "value=" + value,
    ]);
  }
}
