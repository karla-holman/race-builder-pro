class ConditionNodesController < ApplicationController
  before_action :set_condition_node, only: [:show, :edit, :update, :destroy, :addParentOperator, :addChildOperator, :addCondition]
  skip_before_filter  :verify_authenticity_token

  def index
    @condition_nodes = ConditionNode.all
  end

  def show
  end

  def new
    @condition_node = ConditionNode.new
  end

  def edit
  end

  def create
    @condition_node = ConditionNode.new(condition_node_params)

    respond_to do |format|
      if @condition_node.save
        format.html { redirect_to edit_condition_node_path(@condition_node) }
      else
        format.html { redirect_to :back }
      end
    end
  end

  def update
    if params[:update] == "true"
      @condition_node.update(condition_node_params)
      @condition_node.save
    end
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  def destroy
    @condition_node.destroy
    respond_to do |format|
      format.html { redirect_to condition_nodes_url }
      format.json { head :no_content }
    end
  end

  def addParentOperator
    if !params[:node_id].blank?
      base_node = ConditionNode.find_by_id(params[:node_id])
    end

    if base_node
      new_node = ConditionNode.new
      new_node.parent_id = base_node.parent_id
      new_node.setTypeOperator
      new_node.setOperatorOr
      new_node.save

      base_node.parent_id = new_node.id
      base_node.save
    end

    respond_to do |format|
      format.html { redirect_to edit_condition_node_url(@condition_node) }
    end
  end

  def addChildOperator
    if !params[:node_id].blank?
      base_node = ConditionNode.find_by_id(params[:node_id])
    end

    if base_node
      new_node = ConditionNode.new
      new_node.parent_id = base_node.id
      new_node.setTypeOperator
      new_node.setOperatorOr
      new_node.save
    end

    respond_to do |format|
      format.html { redirect_to edit_condition_node_url(@condition_node) }
    end
  end

  def addCondition
    if !params[:node_id].blank?
      base_node = ConditionNode.find_by_id(params[:node_id])
    end

    if base_node
      new_node = ConditionNode.new
      new_node.parent_id = base_node.id
      new_node.setTypeCondition
      new_node.save
    end

    respond_to do |format|
      format.html { redirect_to edit_condition_node_url(@condition_node) }
    end
  end

  def removeNode
    if !params[:node_id].blank?
      base_node = ConditionNode.find_by_id(params[:node_id])
    end

    base_node.parent_id = nil
    base_node.save


    respond_to do |format|
      format.html { redirect_to edit_condition_node_url(@condition_node) }
    end
  end

  private
    def set_condition_node
      @condition_node = ConditionNode.find(params[:id])
    end

    def condition_node_params
      params.require(:condition_node).permit(:parent_id, :node_type, :value)
    end
end
