require "guard/dsl_reader"

RSpec.describe Guard::DslReader, exclude_stubs: [Guard::Dsl] do
  methods = %w(
    initialize guard notification interactor group watch callback
    ignore ignore! logger scope directories clearing
  ).map(&:to_sym)

  methods.each do |meth|
    describe "\##{meth} signature" do
      it "matches base signature" do
        expected = Guard::Dsl.instance_method(meth).arity
        expect(subject.method(meth).arity).to eq(expected)
      end
    end
  end

  describe "guard" do
    it "works without errors" do
      expect { subject.guard("foo", bar: :baz) }.to_not raise_error
    end
  end

  describe "plugin_names" do
    it "returns encountered names" do
      subject.guard("foo", bar: :baz)
      subject.guard("bar", bar: :baz)
      subject.guard("baz", bar: :baz)
      expect(subject.plugin_names).to eq(%w(foo bar baz))
    end
  end

  describe "notification" do
    it "handles arguments without errors" do
      expect { subject.notification(:off) }.to_not raise_error
    end
  end
end
