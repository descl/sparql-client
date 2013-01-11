require File.join(File.dirname(__FILE__), 'spec_helper')

describe SPARQL::Client::Update do
  before :each do
    @sparql = SPARQL::Client::Update
  end

  context "when building queries" do
    it "should support INSERT DATA operations" do
      @sparql.should respond_to(:insert_data)
    end

    it "should support DELETE DATA operations" do
      #@sparql.should respond_to(:delete_data)
    end

    it "should support DELETE/INSERT operations" do
      #@sparql.should respond_to(:what)
      #@sparql.should respond_to(:delete)
      #@sparql.should respond_to(:insert)
    end

    it "should support LOAD operations" do
      #@sparql.should respond_to(:load)
    end

    it "should support CLEAR operations" do
      @sparql.should respond_to(:clear)
    end

    it "should support CREATE operations" do
      #@sparql.should respond_to(:create)
    end

    it "should support DROP operations" do
      #@sparql.should respond_to(:drop)
    end

    it "should support COPY operations" do
      #@sparql.should respond_to(:copy)
    end

    it "should support MOVE operations" do
      #@sparql.should respond_to(:move)
    end

    it "should support ADD operations" do
      #@sparql.should respond_to(:add)
    end
  end

  context "when building INSERT DATA queries" do
    it "should support empty input" do
      @sparql.insert_data(RDF::Graph.new).to_s.should == "INSERT DATA {\n}\n"
    end

    it "should support non-empty input" do
      data = RDF::Graph.new do |graph|
        graph << [RDF::URI('http://example.org/jhacker'), RDF::FOAF.name, "J. Random Hacker"]
      end
      @sparql.insert_data(data).to_s.should ==
        "INSERT DATA {\n<http://example.org/jhacker> <http://xmlns.com/foaf/0.1/name> \"J. Random Hacker\" .\n}\n"
    end

    it "should support the GRAPH modifier" do
      [@sparql.insert_data(RDF::Graph.new, :graph => 'http://example.org/'),
       @sparql.insert_data(RDF::Graph.new).graph('http://example.org/')].each do |example|
        example.to_s.should == "INSERT DATA { GRAPH <http://example.org/> {\n}}\n"
      end
    end
  end

  context "when building CLEAR queries" do
    it "should support the CLEAR GRAPH operation" do
      @sparql.clear.graph('http://example.org/').to_s.should == 'CLEAR GRAPH <http://example.org/>'
      @sparql.clear(:graph, 'http://example.org/').to_s.should == 'CLEAR GRAPH <http://example.org/>'
    end

    it "should support the CLEAR DEFAULT operation" do
      @sparql.clear.default.to_s.should == 'CLEAR DEFAULT'
      @sparql.clear(:default).to_s.should == 'CLEAR DEFAULT'
    end

    it "should support the CLEAR NAMED operation" do
      @sparql.clear.named.to_s.should == 'CLEAR NAMED'
      @sparql.clear(:named).to_s.should == 'CLEAR NAMED'
    end

    it "should support the CLEAR ALL operation" do
      @sparql.clear.all.to_s.should == 'CLEAR ALL'
      @sparql.clear(:all).to_s.should == 'CLEAR ALL'
    end

    it "should support the SILENT modifier" do
      @sparql.clear.all.silent.to_s.should == 'CLEAR SILENT ALL'
      @sparql.clear(:all, :silent => true).to_s.should == 'CLEAR SILENT ALL'
    end
  end
end
