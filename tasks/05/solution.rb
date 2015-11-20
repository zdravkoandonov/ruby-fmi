class ObjectStore
  attr_accessor :current_branch, :stage, :branches
  def initialize()
    @current_branch = :master
    @stage = {}
    @branches = { master: [] }
  end

  def self.init()
    new_store = new
    new_store.instance_eval(&Proc.new) if block_given?
    new_store
  end

  class Outcome
    def initialize(message, success, result = nil)
      @message = message
      @success = success
      @result = result
    end

    def message
      @message
    end

    def success?
      @success
    end

    def error?
      # TODO: fix skeptic
      ! @success
    end

    def result
      @result
    end
  end

  def add(name, object)
    @stage[name] = object
    Outcome.new("Added #{name} to stage.", true, object)
  end

  def commit(message)
    if @stage.size > 0
      @branches[@current_branch] << { message: message, stage: @stage }
      @stage = {}
      Outcome.new("#{message}\n\t#{@branches[@current_branch].last.size}" \
        " objects changed", true)
    else
      Outcome.new("Nothing to commit, working directory clean.", false)
    end
  end

  def remove(name)

  end

  def checkout(commit_hash)

  end

  class Branch
    def initialize(repository)
      @repository = repository
    end

    def create(branch_name)
      if (@repository.branches.has_key?(branch_name.to_sym))
        Outcome.new("Branch #{branch_name} already exists.", false)
      else
        @repository.branches[branch_name.to_sym] =
          @repository.branches[@repository.current_branch].dup
        Outcome.new("Created branch #{branch_name}.", true)
      end
    end

    def checkout(branch_name)
      if (@repository.branches.has_key?(branch_name.to_sym))
        @repository.current_branch = branch_name.to_sym
        Outcome.new("Switched to branch #{branch_name}.", true)
      else
        Outcome.new("Branch #{branch_name} does not exist.", false)
      end
    end

    def remove(branch_name)
      if (@repository.branches.has_key?(branch_name.to_sym))
        if @repository.current_branch == branch_name.to_sym
          Outcome.new("Cannot remove current branch.", false)
        else
          @repository.branches.delete(branch_name.to_sym)
          Outcome.new("Removed branch #{branch_name}.", true)
        end
      else
        Outcome.new("Branch #{branch_name} does not exist.", false)
      end
    end

    def list
      # TODO: sort alphabetically
      message = @repository.branches.keys.sort.
        map { |branch_name| ((branch_name == @repository.current_branch) ? "* " : "  ") + branch_name.to_s }.join("\n")
      Outcome.new(message, true)
    end
  end

  def branch()
    Branch.new(self)
  end

  def log

  end

  def head
    if @branches[@current_branch].size > 0
      Outcome.new(@branches[@current_branch].last[:message], true,
        @branches[@current_branch].last[:stage])
    else
      Outcome.new("Branch #{@current_branch} does not have any commits yet.",
        false)
    end
  end

  def get(name)

  end
end
