{ lib
, buildPythonPackage
, fetchFromGitHub
, setuptools-scm
, atom
, ply
, kiwisolver
, qtpy
, sip_4
, cppy
, bytecode
}:

buildPythonPackage rec {
  pname = "enaml";
  version = "0.16.0";

  src = fetchFromGitHub {
    owner = "nucleic";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-0W5FWGS4vu5+O6/C4El60QDsRNj+P4xGQ62NdkfJd5I=";
  };

  # qt bindings cannot be found during tests
  doCheck = false;

  pythonImportsCheck = [
    "enaml"
    "enaml.applib"
    "enaml.core"
    "enaml.core.parser"
    "enaml.layout"
    # qt bindings cannot be found during checking
    #"enaml.qt"
    #"enaml.qt.docking"
    "enaml.scintilla"
    "enaml.stdlib"
    "enaml.widgets"
    "enaml.workbench"
  ];

  nativeBuildInputs = [ setuptools-scm ];
  propagatedBuildInputs = [
    atom
    ply
    kiwisolver
    qtpy
    sip_4
    cppy
    bytecode
  ];
  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  meta = with lib; {
    homepage = "https://github.com/nucleic/enaml";
    description = "Declarative User Interfaces for Python";
    license = licenses.bsd3;
    maintainers = with maintainers; [ raboof ];
  };
}
