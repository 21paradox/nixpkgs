{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  graphql-core,
  pytest-asyncio,
  pytestCheckHook,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "apischema";
  version = "0.18.3";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "wyfo";
    repo = "apischema";
    rev = "refs/tags/v${version}";
    hash = "sha256-YFJbNxCwDrJb603Bf8PDrvhVt4T53PNWOYs716c0f1I=";
  };

  optional-dependencies = {
    graphql = [ graphql-core ];
  };

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
  ] ++ lib.flatten (builtins.attrValues optional-dependencies);

  pythonImportsCheck = [ "apischema" ];

  meta = with lib; {
    description = "JSON (de)serialization, GraphQL and JSON schema generation using typing";
    homepage = "https://github.com/wyfo/apischema";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
