import project_template


def test_version_exposed():
    assert hasattr(project_template, "__version__")

def test_truth():
    assert True
