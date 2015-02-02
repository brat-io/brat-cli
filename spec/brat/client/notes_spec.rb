require 'spec_helper'

describe Brat::Client do
  describe "notes" do
    context "when wall notes" do
      before do
        stub_get("/projects/3/notes", "notes")
        @notes = Brat.notes(3)
      end

      it "should get the correct resource" do
        expect(a_get("/projects/3/notes")).to have_been_made
      end

      it "should return an array of notes" do
        expect(@notes).to be_an Array
        expect(@notes.first.author.name).to eq("John Smith")
      end
    end

    context "when issue notes" do
      before do
        stub_get("/projects/3/issues/7/notes", "notes")
        @notes = Brat.issue_notes(3, 7)
      end

      it "should get the correct resource" do
        expect(a_get("/projects/3/issues/7/notes")).to have_been_made
      end

      it "should return an array of notes" do
        expect(@notes).to be_an Array
        expect(@notes.first.author.name).to eq("John Smith")
      end
    end

    context "when snippet notes" do
      before do
        stub_get("/projects/3/snippets/7/notes", "notes")
        @notes = Brat.snippet_notes(3, 7)
      end

      it "should get the correct resource" do
        expect(a_get("/projects/3/snippets/7/notes")).to have_been_made
      end

      it "should return an array of notes" do
        expect(@notes).to be_an Array
        expect(@notes.first.author.name).to eq("John Smith")
      end
    end
  end

  describe "note" do
    context "when wall note" do
      before do
        stub_get("/projects/3/notes/1201", "note")
        @note = Brat.note(3, 1201)
      end

      it "should get the correct resource" do
        expect(a_get("/projects/3/notes/1201")).to have_been_made
      end

      it "should return information about a note" do
        expect(@note.body).to eq("The solution is rather tricky")
        expect(@note.author.name).to eq("John Smith")
      end
    end

    context "when issue note" do
      before do
        stub_get("/projects/3/issues/7/notes/1201", "note")
        @note = Brat.issue_note(3, 7, 1201)
      end

      it "should get the correct resource" do
        expect(a_get("/projects/3/issues/7/notes/1201")).to have_been_made
      end

      it "should return information about a note" do
        expect(@note.body).to eq("The solution is rather tricky")
        expect(@note.author.name).to eq("John Smith")
      end
    end

    context "when snippet note" do
      before do
        stub_get("/projects/3/snippets/7/notes/1201", "note")
        @note = Brat.snippet_note(3, 7, 1201)
      end

      it "should get the correct resource" do
        expect(a_get("/projects/3/snippets/7/notes/1201")).to have_been_made
      end

      it "should return information about a note" do
        expect(@note.body).to eq("The solution is rather tricky")
        expect(@note.author.name).to eq("John Smith")
      end
    end
  end

  describe "create note" do
    context "when wall note" do
      before do
        stub_post("/projects/3/notes", "note")
        @note = Brat.create_note(3, "The solution is rather tricky")
      end

      it "should get the correct resource" do
        expect(a_post("/projects/3/notes").
          with(:body => {:body => 'The solution is rather tricky'})).to have_been_made
      end

      it "should return information about a created note" do
        expect(@note.body).to eq("The solution is rather tricky")
        expect(@note.author.name).to eq("John Smith")
      end
    end

    context "when issue note" do
      before do
        stub_post("/projects/3/issues/7/notes", "note")
        @note = Brat.create_issue_note(3, 7, "The solution is rather tricky")
      end

      it "should get the correct resource" do
        expect(a_post("/projects/3/issues/7/notes").
          with(:body => {:body => 'The solution is rather tricky'})).to have_been_made
      end

      it "should return information about a created note" do
        expect(@note.body).to eq("The solution is rather tricky")
        expect(@note.author.name).to eq("John Smith")
      end
    end

    context "when snippet note" do
      before do
        stub_post("/projects/3/snippets/7/notes", "note")
        @note = Brat.create_snippet_note(3, 7, "The solution is rather tricky")
      end

      it "should get the correct resource" do
        expect(a_post("/projects/3/snippets/7/notes").
          with(:body => {:body => 'The solution is rather tricky'})).to have_been_made
      end

      it "should return information about a created note" do
        expect(@note.body).to eq("The solution is rather tricky")
        expect(@note.author.name).to eq("John Smith")
      end
    end
  end
end
