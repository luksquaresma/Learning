let
  pkgs = import <nixpkgs> {
    config = {
      allowUnfree = true;
      # cudaSupport = true;  # If you need CUDA
    };
  };
in

pkgs.mkShell {
  buildInputs = with pkgs; [
    glow
    python3
    # python3Packages.tensorflow
    exercism
    tmux
  ];
}
