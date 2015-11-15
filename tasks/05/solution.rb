class ObjectStore
  def init

  end

  class Outcome
    def message

    end

    def success?

    end

    def error?

    end
  end

  def add(name, object)

  end

  def commit(message)

  end

  def remove(name)

  end

  def checkout(commit_hash)

  end

  class Branch
    def create(branch_name)

    end

    def checkout(branch_name)

    end

    def remove(branch_name)

    end

    def list

    end
  end

  def branch()

  end

  def log

  end

  def head

  end

  def get(name)

  end
end
