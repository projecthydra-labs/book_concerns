= BookConcerns

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
