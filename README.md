# BookConcerns

This project rocks and uses MIT-LICENSE.

### Getting Started Testing

```bash
bundle install
rake engine_cart:generate
rake jetty:clean
rake jetty:config
rake jetty:start
rspec spec
```

### Testing Manually

If you want to run the tests manually, follow these instructions.

```bash
solr_wrapper -d solr/config/ --collection_name hydra-test
```

in another shell run

```bash
fcrepo_wrapper -p 8984
```

Now you’re ready to run the tests. In the directory where active\_fedora
is installed, run:

```bash
rake spec
```

## Contributing

If you're working on PR for this project, create a feature branch off of `main`.

This repository follows the [Samvera Community Code of Conduct](https://samvera.atlassian.net/wiki/spaces/samvera/pages/405212316/Code+of+Conduct) and [language recommendations](https://github.com/samvera/maintenance/blob/master/templates/CONTRIBUTING.md#language).  Please ***do not*** create a branch called `master` for this repository or as part of your pull request; the branch will either need to be removed or renamed before it can be considered for inclusion in the code base and history of this repository.
