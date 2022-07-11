{
  description = "Ready-made templates for easily creating flake-driven environments";

  outputs = { self }: {
    templates = {
      go_1_17 = {
        path = ./go1.17;
        description = "Go 1.17 development environment";
      };

      go_1_18 = {
        path = ./go1.18;
        description = "Go 1.18 development environment";
      };
    };
  };
}