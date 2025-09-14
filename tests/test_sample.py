def test_version_exposed():
    import project_template

    assert hasattr(project_template, "__version__")

def test_truth():
    assert True
