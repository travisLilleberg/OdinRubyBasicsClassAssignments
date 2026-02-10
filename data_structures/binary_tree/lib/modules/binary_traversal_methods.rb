# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

# Methods associated with preorder traversal
module PreorderMethods
  def preorder(&block)
    return if @root.nil?
    return to_enum(:preorder) unless block_given?

    preorder_recur(@root, &block)

    self
  end

  def preorder_loop
    return if @root.nil?
    return to_enum(:preorder_loop) unless block_given?

    stack = [@root]

    until stack.empty?
      current = stack.pop

      yield current.data

      stack << current.right if current.right
      stack << current.left if current.left
    end

    self
  end

  private

  def preorder_recur(node, &block)
    return if node.nil?

    yield node.data
    preorder_recur(node.left, &block)
    preorder_recur(node.right, &block)
  end
end

# Methods associated with inorder traversal
module InorderMethods
  def inorder(&block)
    return if @root.nil?
    return to_enum(:inorder) unless block_given?

    inorder_recur(@root, &block)

    self
  end

  def inorder_loop
    return if @root.nil?
    return to_enum(:inorder_loop) unless block_given?

    stack = []
    current = @root

    until current.nil? && stack.empty?
      while current
        stack << current
        current = current.left
      end

      current = stack.pop
      yield current.data

      current = current.right
    end

    self
  end

  private

  def inorder_recur(node, &block)
    return if node.nil?

    inorder_recur(node.left, &block)
    yield node.data
    inorder_recur(node.right, &block)
  end
end

# Methods associated with postorder traversal
module PostorderMethods
  def postorder(&block)
    return if @root.nil?
    return to_enum(:postorder) unless block_given?

    postorder_recur(@root, &block)

    self
  end

  def postorder_loop
    return if @root.nil?
    return to_enum(:postorder_loop) unless block_given?

    stack = []
    current = @root
    prev_node = nil

    until current.nil? && stack.empty?
      if current
        stack << current
        current = current.left
      else
        top = stack.last
        if top.right && (prev_node.nil? || top.right != prev_node)
          current = top.right
        else
          prev_node = stack.pop
          yield prev_node.data
        end
      end
    end

    self
  end

  private

  def postorder_recur(node, &block)
    return if node.nil?

    postorder_recur(node.left, &block)
    postorder_recur(node.right, &block)
    yield node.data
  end
end

# Contains methods for traversal in Tree.rb class (or any binary tree class).
module BinaryTraversalMethods
  include PreorderMethods
  include InorderMethods
  include PostorderMethods

  def level_order
    return unless @root
    return to_enum(:level_order) unless block_given?

    queue = [@root]
    front = 0
    while queue[front]
      current = queue[front]

      yield current.data

      queue << current.left if current.left
      queue << current.right if current.right

      front += 1
    end

    self
  end
end

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
