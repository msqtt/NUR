self: super: {
  fcitx5-rime = super.fcitx5-rime.override {
    rime-data = ./rime;
    rimeDataPkgs = [ ./rime ];
  };
}
